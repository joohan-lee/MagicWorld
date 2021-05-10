<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%
	String userId="";
	userId = (String)session.getAttribute("userId");
	if(userId==null||userId.equals(""))
	{
		%><script>alert("잘못된 로그인");
		location.href="LoginMain.html";
		</script>
	
	<%}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>wizardMyInfoView</title>
<style>
	#header{
		width:100%;
		background-color:cyan;
		color:gray;
		float:left;
		text-align:right;
	}
	#nav{
		width:200px;
		float:left;
		background-color:yellow;
	}
	#container{
		float:left;
		width:800px;
		text-align:center;
		padding-top:30px;
		padding-left:30px;
	}
	tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
		text-align:center;
	}
	strong{
		background-color:cyan;
	}
</style>

</head>
<body>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
String dbUser = "root";
String dbPass = "8787";

try{
	conn = DriverManager.getConnection(jdbcDriver, dbUser,dbPass);
	stmt = conn.createStatement();
	String sql = "select * from wizards where WizardID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myName = null;
	int myAge=-1;
	String myTribe = null;
	String myHometown = null;
	String myOccupation = null;
	int myClass = -1;
	String myAttribute = null;
	int myMana= -1;
	int myBalance = -1;
	
	while(rs.next()){
		myName = rs.getString("Name");
		myAge = rs.getInt("Age");
		myTribe = rs.getString("Tribe");
		myHometown = rs.getString("Hometown");
		myOccupation = rs.getString("Occupation");
		myClass = rs.getInt("Class");
		myAttribute = rs.getString("Attribute");
		myMana = rs.getInt("Mana");
		myBalance = rs.getInt("Balance");

%>


	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li><a href="wizardMaterialRegit.jsp">새로운 재료 등록</a></li>
			<li><a href="wizardMagicRegit.jsp">새로운 마법 등록</a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="wizardMyInfoView.jsp"><strong>확인</strong></a></li>
					<li><a href="wizardMyInfoModify.jsp">수정</a></li>
				</ul>
			<li>나의 창조한 마법</li>
				<ul>
					<li><a href="wizardMyMagicView.jsp">확인</a></li>
					<li><a href="wizardMyMagicModify.jsp">수정</a></li>
				</ul>
			<li><a href="wizardMyMagicTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
			<table>
			<caption>마법사 <%=myName %>님의 정보</caption>
				<tr>
					<th width="30%">아이디</th>
					<td width="70%">
						<%=userId %>
					</td>
				</tr>
				<tr>
					<th width="30%">이름</th>
					<td width="70%">
						<%=myName %>
					</td>
				</tr>
				<tr>
					<th width="30%">나이</th>
					<td width="70%">
						<%=myAge %>
					</td>
				</tr>
				<tr>
					<th width="30%">종족</th>
					<td width="70%">
						<%=myTribe %>
					</td>
				</tr>
				<tr>
					<th width="30%">출신지</th>
					<td width="70%">
						<%=myHometown %>
					</td>
				</tr>
				<tr>
					<th width="30%">직업</th>
					<td width="70%">
						<%=myOccupation %>
					</td>
				</tr>
				<tr>
					<th width="30%">클래스</th>
					<td width="70%">
						<%=myClass %>
					</td>
				</tr>
				<tr>
					<th width="30%">속성</th>
					<td width="70%">
						<%=myAttribute %>
					</td>
				</tr>
				<tr>
					<th width="30%">마나량</th>
					<td width="70%">
						<%=myMana %>
					</td>
				</tr>
				<tr>
					<th width="30%">소지금</th>
					<td width="70%">
						<%=myBalance %>
					</td>
				</tr>
			</table>
			
			<table style="width:300px;">
			<caption>내가 소속된 마법상회 목록</caption>
				<thead>
					<tr>
						<th>마법상회ID</th>
						<th>상호</th>
					</tr>
				</thead>
				<tbody>
					<%
			String shopId = null;
			String shopName = null;
			sql = "select * from belongings, shops where belongings.shopid = shops.shopid and belongings.wizardid= '"+userId+"';";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				shopId = rs.getString("ShopID");
				shopName = rs.getString("ShopName");

			%>
		<tr>
			<td><a href="popupShopDetail.jsp?shopId=<%=shopId%>"><%=shopName %></a></td>
			<td><%=shopId %></td>
		</tr>
		<%
		}//while(rs)
		%>
				
				</tbody>
			</table>
	</div>

<%
	}//while
	}catch(Exception e){
	e.printStackTrace();
	}finally{
	try{
		if(rs!=null) {rs.close();}
		if(stmt!=null) {stmt.close();}
		if(conn!=null) {conn.close();}
	}catch(SQLException e){
		e.printStackTrace();
	}
	}

%>

</body>
</html>