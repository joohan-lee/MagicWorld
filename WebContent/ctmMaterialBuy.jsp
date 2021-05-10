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
<title>ctmMaterialBuy</title>
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
	String sql2=null;
	
	String sShopid = null;
	String sShopname = null;
	String sAddress = null;
	String sChiefname = null;
	int sPermitclass = -1;
	int sShopbalance = -1;
	
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
			<li><a href="ctmMaterialBuy.jsp"><strong>재료구매</strong></a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="ctmMyInfoView.jsp">확인</a></li>
					<li><a href="ctmMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="ctmMyTrans.jsp">내 거래내역</a></li>
			<li><a href="ctmMyMagicView.jsp">구매한 마법</a></li>			
		</ul>
	</div>
	
	<div id="container">
		<table>
		<caption>내 거래처(마법상회) 목록</caption>
	  		<thead>
				<tr>
     		    	<th>마법상회ID</th>
					<th>상호</th>
					<th>주소</th>
					<th>대표자이름</th>
					<th>거래허가클래스</th>
					<th>소지금</th>
					<th>선택</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%
   					sql="select * from clients where CustomerID='"+userId+"';";
   					rs=stmt.executeQuery(sql);
   					
   					while(rs.next()){
   					String shopId = rs.getString("ShopID");
   					sql2 ="select * from shops where ShopID ='"+shopId+"';";
   					rs2 = stmt.executeQuery(sql2);

   					while(rs2.next()){
   					sShopid = rs2.getString("ShopID");
   					sShopname = rs2.getString("ShopName");
   					sAddress = rs2.getString("Address");
   					sChiefname = rs2.getString("ChiefName");
   					sPermitclass = rs2.getInt("PermitClass");
   					sShopbalance = rs2.getInt("ShopBalance");
   					
   				%>
				<tr>
					<td><%=sShopid %></td>
					<td><%=sShopname %></td>
					<td><%=sAddress %></td>
					<td><%=sChiefname %></td>
					<td><%=sPermitclass %></td>
					<td><%=sShopbalance %></td>
					<td>
					<input type="button" value="선택" onclick="location.href='ctmMaterialBuy2.jsp?shopId=<%=sShopid%>'" 
					style="cursor:pointer;">
					</td>
				</tr>
				<%}//while(rs2)
				}//while(rs)%>
			</tbody>
			</table>
	</div>
	
	<%

	}catch(Exception e){
	e.printStackTrace();
	}finally{
	try{
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
	}

	%>

</body>
</html>