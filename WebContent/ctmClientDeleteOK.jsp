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
	String shopId = request.getParameter("shopId");
	
%>
<html>
<head>
<meta charset="EUC-KR">
<title>ctmClientDeleteOK</title>
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

			String sql = "delete from clients"
					+ " where ShopID ='"+shopId+"' and CustomerID = '"+userId+"';";
				out.println(sql);
				int result = stmt.executeUpdate(sql);
				if(result>0){
				%><script>alert('삭제가 완료되었습니다.');
				location.href="ctmClientDelete.jsp";
				</script>
				<%
				}
				else{
					%><script>alert('삭제에 실패하였습니다.');
				history.go(-1);
				</script><%
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null){rs.close();}
				if(stmt!=null){stmt.close();};
				if(conn!=null){conn.close();};
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>