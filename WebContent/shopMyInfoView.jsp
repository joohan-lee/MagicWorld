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
<title>shopMyInfoView</title>
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
	}
	table, tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
	}
	strong{
		background-color:pink;
	}

</style>

<script>
function popupWizard(str){
	 var url = "popupWizardDetail.jsp?wizardId="+str;
   	 var name = "popup test";
   	 var option = "width = 500, height = 500, top = 100, left = 200, location = no"
   	 window.open(url, name, option);
}
function popupMaterial(str){
    var url = "popupMaterialInfo.jsp?mtid="+str;
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
</script>

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
	String sql = null;
	String sql2= null;
	
	sql = "select * from shops where ShopID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myShopname = null;
	String myAddress = null;
	String myChiefname = null;
	int myPermitclass = -1;
	int myShopbalance = -1;
	
	while(rs.next()){
		myShopname = rs.getString("ShopName");
		myAddress = rs.getString("Address");
		myChiefname = rs.getString("ChiefName");
		myPermitclass = rs.getInt("PermitClass");
		myShopbalance = rs.getInt("ShopBalance");

%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>소속 마법사</li>
				<ul>
					<li><a href="shopWizardRegit.jsp">등록</a></li>
					<li><a href="shopWizardDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="shopMaterialRegit.jsp">재료 재고 등록</a></li>
			<li>나의 마법상회 정보</li>
				<ul>
					<li><a href="shopMyInfoView.jsp"><strong>확인</strong></a></li>
					<li><a href="shopMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="shopTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
		<table>
			<caption>내 마법상회 정보</caption>
				<tr>
					<th width="30%">아이디</th>

					<td width="70%">
						<%=userId %>
					</td>
				</tr>
				<tr>
					<th width="30%">가게 이름</th>
					<td width="70%">
						<%=myShopname %>
					</td>
				</tr>
				<tr>
					<th width="30%">주소</th>
					<td width="70%">
						<%=myAddress %>
					</td>
				</tr>
				<tr>
					<th width="30%">대표자이름</th>
					<td width="70%">	
						<%=myChiefname %>					
					</td>
				</tr>
				<tr>
					<th width="30%">거래허가 클래스</th>
					<td width="70%">
						<%=myPermitclass %>
					</td>
				</tr>
				<tr>
					<th width="30%">소지금</th>
					<td width="70%">
						<%=myShopbalance %>
					</td>
				</tr>
		</table>
<%		}//while %>
		
		
		<table style="width:300px;text-align:center;">
			<caption>내 마법상회 소속 마법사 목록</caption>
			<thead>
			<tr>
				<th>마법사이름</th>
				<th>마법사ID</th>
			</tr>
			</thead>
			<tbody>
		<%
		String wizardId = null;
		String wizardName = null;
		sql = "select * from belongings where ShopID = '"+userId+"';";
		sql2 = "select * from wizards where WizardID = '"+wizardId+"';";

		rs = stmt.executeQuery(sql);
		while(rs.next()){
			wizardId = rs.getString("WizardID");
			rs2=stmt.executeQuery(sql2);
			while(rs2.next()){
				wizardName = rs2.getString("Name");

		%>
		<tr>
			<td><a href="popupWizardDetail.jsp?wizardId=<%=wizardId%>"><%=wizardName %></a></td>
			<td><%=wizardId %></td>
		</tr>
		<%
			}//while(rs)
		}//while(rs2)
		%>
		</tbody>
		</table>		
		
		<table style="width:300px;text-align:center;">
		<caption>내 마법상회 보유 재고 목록</caption>
			<thead>
			<tr>
				<th>재료이름</th>
				<th>재료ID</th>
				<th>재고량</th>
			</tr>
			</thead>
			<tbody>
			<%
			int materialId = -1;
			String materialName = null;
			int stock = -1;
			int i=1;
			sql = "select * from sales where ShopID = '"+userId+"';";

			rs = stmt.executeQuery(sql);

			while(rs.next()){
				materialId = rs.getInt("MaterialID");
				stock = rs.getInt("Stock");
				sql2 = "select * from materials where MaterialID = "+materialId+";";
				rs2=stmt.executeQuery(sql2);

				while(rs2.next()){
					materialName = rs2.getString("Name");
			%>
			<tr>
				<td><a href="javascript:popupMaterial(<%=materialId%>)"><%=materialName %></a></td>
				<td><%=materialId %></td>
				<td><%=stock %></td>
			</tr>
			<%
				}//while(rs)
			}//while(rs2)
			%>
			</tbody>
		</table>
	</div>

<%
	
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