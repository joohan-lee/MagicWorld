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
	int mtPrice = Integer.parseInt(request.getParameter("mtPrice"));
	String mtId = request.getParameter("mtId");
	int new_stock = Integer.parseInt(request.getParameter("input_stock"));
%>
<html>
<head>
<meta charset="utf-8">
<title>shopMaterialRegitOK</title>
</head>
<body>
	<%
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;

		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";

		try {
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			
			//내 상점의 소지금 받아오기.
			int sBalance = -1;
			sql = "select * from shops where ShopID ='"+userId+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				sBalance = rs.getInt("ShopBalance");
			}
									
			
			if(sBalance>=(mtPrice*new_stock)){//소지금>=가격*재고량이면 등록 후 소지금 차감.
			
			//있으면 update 없으면 insert
			sql = "insert into sales(ShopID, MaterialID,Stock)"
					+ " values('" + userId + "',"+mtId+","+new_stock+")"+
					" on duplicate key update Stock = Stock + "+new_stock;

			out.println(sql);
			stmt.executeUpdate(sql);
			
			sql = "update shops set ShopBalance = "+ (sBalance-(mtPrice*new_stock)) +
					" where ShopID='"+userId+"';";
			stmt.executeUpdate(sql);
			out.println(sql);
			
			out.println("재료재고등록완료");

			%><script>alert('등록이 완료되었습니다.');
			location.href="shopMaterialRegit.jsp";
			</script><%
			}
			else{
				%><script>alert('소지금이 부족합니다.');
				location.href="shopMaterialRegit.jsp";
				</script><%
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null){rs.close();}
				if(stmt!=null){stmt.close();}
				if(conn!=null){conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>