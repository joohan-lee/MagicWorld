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
	String new_description = request.getParameter("input_description");
	int new_class = Integer.parseInt(request.getParameter("input_class"));
	String new_attribute = request.getParameter("input_attribute");
	String new_type = request.getParameter("input_typeSelect");
	int new_effectiveness = Integer.parseInt(request.getParameter("input_effectiveness"));
	int new_mana_consumption = Integer.parseInt(request.getParameter("input_mana_consumption"));
	int new_price = Integer.parseInt(request.getParameter("input_price"));
	
	String new_materialId = request.getParameter("input_materialSelect");
	int new_requisite = Integer.parseInt(request.getParameter("input_requisite"));

%>
<html>
<head>
<meta charset="utf-8">
<title>wizardMagicRegitOK</title>
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
			String values = "'" + new_name + "','" + new_description + "'," + new_class + ",'"
					+ new_attribute + "','" + new_type + "'," + new_effectiveness + ","
					+ new_mana_consumption + "," + new_price + ",'" + userId + "'";
			String sql = "insert into magics(Name, Description ,Class ,Attribute, Type,"
					+ "Effectiveness, Mana_consumption, Price, WizardID)"
					+ " values(" + values + ");";

			out.println(sql);
			stmt.executeUpdate(sql);
			out.println("마법등록완료");
			
			rs = stmt.executeQuery("select last_insert_id()");
			int last_id=-1;
			if(rs.next()){
				last_id = rs.getInt(1);
			}
			values = last_id + "," + new_materialId + "," + new_requisite;
			sql = "insert into requisites(MagicID, MaterialID,Requirement)"
					+ " values(" + values + ");";	
			out.print(last_id);
			out.println(sql);
			stmt.executeUpdate(sql);
			out.println("필요테이블등록완료");
			
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