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
</head>
<body>
<%
String MaterialId = request.getParameter("mtid");

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
	String sql = "select * from materials where MaterialID = '" + MaterialId + "';";
	
	String mtId = null;
	String mtName = null;
	String mtOrigin = null;
	String mtType = null;
	int mtPrice = -1;
	%>

<table style="border:1px solid black;text-align:center;">
	  		<thead>
				<tr>
     		    	<th>재료ID</th>
					<th>이름</th>
					<th>원산지</th>
					<th>종류</th>
					<th>가격</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%   
   				rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					mtId = rs.getString("MaterialID");
   					mtName = rs.getString("Name");
   					mtOrigin = rs.getString("Origin");
   					mtType = rs.getString("Type");
   					mtPrice = rs.getInt("Price");
   				%>
				<tr>
					<td><%=mtId %></td>
					<td><%=mtName %></td>
					<td><%=mtOrigin %></td>
					<td><%=mtType %></td>
					<td><%=mtPrice %></td>
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