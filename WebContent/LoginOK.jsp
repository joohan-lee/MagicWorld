<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import ="javax.crypto.*" %>

<!DOCTYPE html>
<%
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	String userRole = request.getParameter("userRole");
%>
<html>
<head>
<meta charset="utf-8">
<title>login ok</title>
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
			if(userRole==null||userRole.equals("")){
				%><script>alert("잘못된 접근");location.href="LoginMain.html";</script><%
			}
			else if (userRole.equals("Wizard")) {
				String sql = "select WizardID, des_decrypt(Password) from wizards;";
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					String id = rs.getString(1);
					String pw = rs.getString(2);

					if (userId.equals(id) && userPw.equals(pw)) {
						response.sendRedirect("wizardMainView.jsp");
						session.setAttribute("userId", id);
						session.setAttribute("userPw", pw);
					}
					else if (userId.equals("") && userPw.equals("")) {
	%>
	<script>
		alert('아이디 혹은 비밀번호를 입력해주세요.');
		location.href="LoginMain.html";
	</script>
	<%
					} 
					else {
	%>
	<script>
		alert('아이디 혹은 비밀번호가 틀렸습니다.');
		location.href="LoginMain.html";
	</script>

	<%
					}//else
				}//while
			}//if(wizard)
			
			else if(userRole.equals("Shop")){
				String sql = "select ShopID, des_decrypt(Password) from shops;";
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					String id = rs.getString(1);
					out.println(id);
					String pw = rs.getString(2);
					out.println(pw);

					if (userId.equals(id) && userPw.equals(pw)) {
						response.sendRedirect("shopMainView.jsp");
						session.setAttribute("userId", id);
						session.setAttribute("userPw", pw);
					}
					else if (userId.equals("") && userPw.equals("")) {
					%>
					<script>
						alert('아이디 혹은 비밀번호를 입력해주세요.');
						location.href="LoginMain.html";
					</script>
					<%
					} 
					else {
					%>
					<script>
						alert('아이디 혹은 비밀번호가 틀렸습니다.');
						location.href="LoginMain.html";
					</script>

					<%
					}//else
				}//while
			}//else if(shop)
			else{
				String sql = "select CustomerID, des_decrypt(Password) from customers;";
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					String id = rs.getString(1);
					String pw = rs.getString(2);

					if (userId.equals(id) && userPw.equals(pw)) {
						response.sendRedirect("ctmMainView.jsp");
						session.setAttribute("userId", id);
						session.setAttribute("userPw", pw);
					}
					else if (userId.equals("") && userPw.equals("")) {
					%>
					<script>
						alert('아이디 혹은 비밀번호를 입력해주세요.');
						location.href="LoginMain.html";
					</script>
					<%
					} 
					else {
					%>
					<script>
						alert('아이디 혹은 비밀번호가 틀렸습니다.');
						location.href="LoginMain.html";
					</script>

					<%
					}//else
				}//while
			}//else(customer)

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>

</body>
</html>