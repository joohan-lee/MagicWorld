<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String identity = (String) request.getParameter("get_id");
	int n = Integer.parseInt(request.getParameter("n"));
%>

<html>

<head>
<script>
	function clk_btn(val){
		var en;
		if(val == 1){
			en = "<%=identity%>";
		} else if (val == 0) {
			en = "cancel";
		} else {
			en = "disable";
		}
		window.returnValue = en;
		window.close();
	}
</script>

<title>id 중복 검사</title>
</head>
<body>
	<%
		boolean chk_id = true;

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";

		try {
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			String sql = null;
			String id1=null;
			if(n==1){
				sql = "select * from wizards;";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					id1 = rs.getString("WizardID");
					if (id1.equals(identity)) {
						chk_id = false;
						break;
					}
				}
			}
			else if(n==2){
				sql = "select * from shops;";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					id1 = rs.getString("ShopID");
					if (id1.equals(identity)) {
						chk_id = false;
						break;
					}
				}
			}
			else if(n==3){
				sql = "select * from customers;";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					id1 = rs.getString("CustomerID");
					if (id1.equals(identity)) {
						chk_id = false;
						break;
					}
				}
			}
				
				
			String enableID = "enable";
			if (chk_id == true) {
				enableID = "enable";
	%><%=identity%>
	- 사용 가능.
	<br> 사용하시겠습니까?
	<br>
	<br>
	<input type="button" value="예" onclick="clk_btn(1)">
	<input type="button" value="아니오" onclick="clk_btn(0)">
	<%
		} else {
	%><%=identity%>
	- 는 사용할 수 없는 ID 입니다.
	<br>
	<br>
	<input type="button" value="예" onclick="clk_btn(2)">
	<%
		}

			session.setAttribute("enableID", enableID);
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
			e.printStackTrace();
			out.println("연결실패");
		}
	%>

</body>
</html>