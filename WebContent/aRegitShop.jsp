<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<%
	String new_id = (String)request.getParameter("input_id2");
	String new_pw1 = request.getParameter("input_pw1");
	String new_pw2 = request.getParameter("input_pw2");
	String new_name = request.getParameter("input_name");
	String new_address = request.getParameter("input_address");
	String new_chiefname = request.getParameter("input_chiefname");
	int new_class = Integer.parseInt(request.getParameter("input_permitclass"));
	int new_balance = 10000;

	String chk_id = request.getParameter("checked_id2");
%>
<html>
<head>
<meta charset="utf-8">
<title>aInsertWizardInfo</title>
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
			String values = "'" + new_id + "', des_encrypt('" + new_pw1 + "'),'" + new_name + "','" + new_address
					+ "','" + new_chiefname + "','" + new_class + "','" + new_balance + "'";
			String sql = "insert into shops(ShopID, Password, ShopName,Address,ChiefName,PermitClass,ShopBalance)"
					+ " values(" + values + ");";
					
			//예외상황들 처리.
			if (!chk_id.equals("true")) {
	%>
	<script>
		alert('아이디 중복확인을 해주세요.');
		history.go(-1);
	</script>
	<%
		} else if (!new_pw1.equals(new_pw2)) {
	%>
	<script>
		alert('비밀번호가 다릅니다.');
		history.go(-1);
	</script>
	<%
		} else {
				out.println(sql);
				stmt.executeUpdate(sql);
	%>
	<script>
		alert('가입이 완료되었습니다.');
		location.href="LoginMain.html";
	</script>
	<%}
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