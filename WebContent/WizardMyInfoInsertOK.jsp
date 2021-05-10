<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
	String WizardID = request.getParameter("WizardID");
	String Password = request.getParameter("Password");
	String Name = request.getParameter("Name");
	int Age = Integer.parseInt(request.getParameter("Age"));
	String Tribe = request.getParameter("Tribe");
	String Hometown = request.getParameter("Hometown");
	String Occupation = request.getParameter("Occupation");
	int Class = Integer.parseInt(request.getParameter("Class"));
	String Attribute = request.getParameter("Attribute");
	int Mana = Integer.parseInt(request.getParameter("Mana"));
	int Balance = Integer.parseInt(request.getParameter("Balance"));
	
%>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
	String dbUser = "root";
	String dbPass = "8787";

try{
	conn = DriverManager.getConnection(jdbcDriver, dbUser,dbPass);
	stmt = conn.createStatement();
	String sql = "insert into wizards(WizardID, Password, Name,Age,Tribe,Hometown,Occupation,Class,Attribute,Mana,Balance)"
			+" values('"+WizardID+"', '"+ Password+"', '"+ Name +"', "+ Age + ", '" + Tribe +"', '"+Hometown+"', '"+ Occupation
			+"', "+Class+", '"+Attribute+"', "+Mana+", "+Balance+");";
	out.println(sql);
	stmt.executeUpdate(sql);
	
	%>
	<script>
		alert('정보가 DB에 등록되었습니다.');
		location.href="WizardMyInfoInsert.jsp";
	</script>
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