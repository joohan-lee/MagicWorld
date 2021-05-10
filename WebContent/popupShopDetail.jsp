<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
    
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
<title>popup</title>
<style>
table, tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
}
</style>
</head>
<body>
<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
</div>
<%
String shopId = request.getParameter("shopId");

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
	String sql = "select * from shops where ShopID = '" + shopId + "';";
	
	String sId = null;
	String sName = null;
	String sAddress = null;
	String sChiefname = null;
	int sPermitclass = -1;
	int sBalance = -1;
	%>

<table style="border:1px solid black;text-align:center;">
	  		<thead>
				<tr>
     		    	<th>마법상회ID</th>
					<th>상호</th>
					<th>주소</th>
					<th>대표자이름</th>
					<th>거래허가클래스</th>
					<th>소지금</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%   
   				rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					sId = rs.getString("ShopID");
   					sName = rs.getString("ShopName");
   					sAddress = rs.getString("Address");
   					sChiefname = rs.getString("ChiefName");
   					sPermitclass = rs.getInt("PermitClass");
   					sBalance = rs.getInt("ShopBalance");

   				%>
				<tr>
					<td><%=sId %></td>
					<td><%=sName %></td>
					<td><%=sAddress %></td>
					<td><%=sChiefname %></td>
					<td><%=sPermitclass %></td>
					<td><%=sBalance %></td>
					
				</tr>
				<%
				}
				%>
			</tbody>
		</table>


<%

	}catch(Exception e){
	e.printStackTrace();
	}finally{
	try{
		rs.close();
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
	}

%>
</body>
</html>