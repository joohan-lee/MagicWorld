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
	String mId = request.getParameter("mId");
	String new_name = request.getParameter("input_name");
	String new_description = request.getParameter("input_description");
	int new_class = Integer.parseInt(request.getParameter("input_class"));
	String new_attribute = request.getParameter("input_attribute");
	String new_type = request.getParameter("input_typeSelect");
	int new_effectiveness = Integer.parseInt(request.getParameter("input_effectiveness"));
	int new_mana_consumption = Integer.parseInt(request.getParameter("input_mana_consumption"));
	int new_price = Integer.parseInt(request.getParameter("input_price"));
%>
<html>
<head>
<meta charset="utf-8">
<title>wizardMyMagicModifyOK</title>
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

			String sql = "update magics set name = '" + new_name
					+ "', description = '" + new_description + "',class="+new_class+",attribute= '"
					+new_attribute+"',type= '"+new_type + "',effectiveness = "+new_effectiveness+
					",mana_consumption = "+new_mana_consumption+",price="+new_price
					+ " where MagicID='" +mId+"'";
				out.println(sql);
				int result = stmt.executeUpdate(sql);
				if(result>0){
				%><script>alert('수정이 완료되었습니다.');
				location.href="wizardMyMagicView.jsp";
				</script>
				<%
				}
				else{
					%><script>alert('수정에 실패하였습니다.');
				history.go(-1);
				</script><%
				}
			
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