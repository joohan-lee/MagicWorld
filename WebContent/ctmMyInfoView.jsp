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
<title>ctmMyInfoView</title>

<script>
function popupShop(str){
    var url = "popupShopDetail.jsp?shopId="+str;
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
</script>

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
		background-color:white;
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
	String sql = null;
	String sql2= null;
	
	sql = "select * from customers where CustomerID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myName = null;
	int myAge = -1;
	String myAddress = null;
	String myAttribute = null;
	int myBalance = -1;
	
	while(rs.next()){
		myName = rs.getString("Name");
		myAge = rs.getInt("Age");
		myAddress = rs.getString("Address");
		myAttribute = rs.getString("Attribute");
		myBalance = rs.getInt("Balance");

%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>거래처</li>
				<ul>
					<li><a href="ctmClientRegit.jsp">등록</a></li>
					<li><a href="ctmClientDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="ctmMagicBuy.jsp">마법구매</a></li>
			<li><a href="ctmMaterialBuy.jsp">재료구매</a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="ctmMyInfoView.jsp"><strong>확인</strong></a></li>
					<li><a href="ctmMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="ctmMyTrans.jsp">내 거래내역</a></li>
			<li><a href="ctmMyMagicView.jsp">구매한 마법</a></li>			
		</ul>
	</div>
	
	<div id="container">
		<table>
			<caption>내 정보</caption>
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
					<th width="30%">주소</th>
					<td width="70%">	
						<%=myAddress %>					
					</td>
				</tr>
				<tr>
					<th width="30%">속성</th>
					<td width="70%">
						<%=myAttribute %>
					</td>
				</tr>
				<tr>
					<th width="30%">소지금</th>
					<td width="70%">
						<%=myBalance %>
					</td>
				</tr>
		</table>
<%		}//while %>
	</div>

	<table style="width:300px;text-align:center;">
			<caption>내 거래처(마법상회) 목록</caption>
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
		sql = "select * from clients, shops where clients.shopid = shops.shopid and clients.customerid = '"+userId+"';";
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