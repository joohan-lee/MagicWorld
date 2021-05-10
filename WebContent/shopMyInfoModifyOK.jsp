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
String new_pw1 = request.getParameter("input_pw1");
String new_pw2 = request.getParameter("input_pw2");
String new_name = request.getParameter("input_name");
String new_address = request.getParameter("input_address");
String new_chiefname = request.getParameter("input_chiefname");
int new_balance = Integer.parseInt(request.getParameter("input_shopbalance"));
%>
<html>
<head>
<meta charset="utf-8">
<title>shopMyInfoModifyOK</title>
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

			String sql = "update shops set password = des_encrypt('" +  new_pw1 + "'), shopname = '" + new_name
					+ "',address = '" + new_address + "',chiefname='"+new_chiefname+"',shopbalance = "+new_balance
					+ " where ShopID='" +userId+"'";
			if(!new_pw1.equals(new_pw2)){
				%>
				<script>
					alert('비밀번호가 다릅니다.');
					history.go(-1);
				</script>
				<%
			}
			else{
				out.println(sql);
				int result = stmt.executeUpdate(sql);
				if(result>0){
				%><script>alert('수정이 완료되었습니다.');
				location.href="shopMyInfoView.jsp";
				</script>
				<%
				}
				else{
					%><script>alert('수정에 실패하였습니다.');
				history.go(-1);
				</script><%
				}
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