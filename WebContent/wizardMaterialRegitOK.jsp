<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

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
<%
	String new_name = request.getParameter("input_name");
	String new_origin= request.getParameter("input_origin");
	String new_type= request.getParameter("input_typeSelect");
	int new_price = Integer.parseInt(request.getParameter("input_price"));
%>
<html>
<head>
<meta charset="utf-8">
<title>wizardMaterialRegitOK</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";

		try {
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			String values = "'" + new_name + "','" + new_origin + "','" + new_type + "',"
					+ new_price;
			String sql = "insert into materials(Name, Origin,Type,Price)"
					+ " values(" + values + ");";

			out.println(sql);
			stmt.executeUpdate(sql);
			
			%><script>alert('등록이 완료되었습니다.');
			location.href="wizardMainView.jsp";
			</script><%
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>