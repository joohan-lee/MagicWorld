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
<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
</div>
<%
String WizardId = request.getParameter("wizardId");

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
	
	String wId = null;
	String wName = null;
	int wAge = -1;
	String wTribe = null;
	String wHometown=null;
	String wOccupation =null;
	int wClass=-1;
	String wAttribute=null;
	int wMana=-1;
	int wBalance = -1;
	%>

<table style="border:1px solid black;text-align:center;">
	  		<thead>
				<tr>
     		    	<th>마법사ID</th>
					<th>이름</th>
					<th>나이</th>
					<th>종족</th>
					<th>출신지</th>
					<th>직업</th>
					<th>클래스</th>
					<th>속성</th>
					<th>마나량</th>
					<th>소지금</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%  
   				sql="select * from wizards where WizardID = '" + WizardId + "';";
   				rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					wId = rs.getString("WizardID");
   					wName = rs.getString("Name");
   					wAge = rs.getInt("Age");
   					wTribe = rs.getString("Tribe");
   					wHometown = rs.getString("Hometown");
   					wOccupation = rs.getString("Occupation");
   					wClass = rs.getInt("Class");
   					wAttribute = rs.getString("Attribute");
   					wMana = rs.getInt("Mana");
   					wBalance = rs.getInt("Balance");


   					

   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					
					
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