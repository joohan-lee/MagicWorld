<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
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
<html>
<head>
<meta charset="utf-8">
<title>ctmMagicBuyOK</title>
</head>
<body>
<%
		String magicId = request.getParameter("magicId");
		int materialId = Integer.parseInt(request.getParameter("materialId"));
		String shopId = request.getParameter("shopId");
		String magicAttr = request.getParameter("magicAttr");
		String magicWizid = request.getParameter("magicWizid");
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql =null;
		String sql2 = null;
		String sql3 = null;

		String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
		String dbUser = "root";
		String dbPass = "8787";

		try {
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			
			//마법속성 = 자기속성이면 마법가격 10%할인
			String myAttr = null;
			sql = "select * from customers where CustomerID='"+userId+"';";
			rs = stmt.executeQuery(sql);
			out.println(sql);

			if(rs.next()){
				myAttr = rs.getString("Attribute");
			}
			out.println("myattr:"+myAttr);
			out.println("magicattr:"+magicAttr);
			if(magicAttr.equals(myAttr)){
				sql = "update magics set Price = Price*0.9 where MagicID = '"+magicId+"';";
				stmt.executeUpdate(sql);
				out.println(sql);
			}
					
			//마법가격을 50%는 마법상회, 50%는 창조 마법사에게 지급.
			int finalPrice = -1;
			sql = "select * from magics where MagicID= '"+magicId+"';";
			rs =stmt.executeQuery(sql);
			if(rs.next()){
				finalPrice = rs.getInt("Price");
			}
			sql = "update shops set ShopBalance = ShopBalance+"+finalPrice*0.5+" where ShopID='"+shopId+"';";
			sql2 = "update wizards set Balance = Balance + "+finalPrice*0.5+" where WizardID ='"+magicWizid+"';";
			stmt.executeUpdate(sql);
			stmt.executeUpdate(sql2);
			
			//본인 소지금 차감.
			sql = "update customers set Balance = Balance - "+finalPrice+" where CustomerID = '"+userId+"';";
			stmt.executeUpdate(sql);
			
			//마법상회 판매 테이블에서 판매된 마법(재료) 삭제.(타 상점에서 팔리던 것도 삭제)
			sql = "delete from sales"
					+ " where MaterialID = "+materialId+";";
			int result1 = stmt.executeUpdate(sql);
			out.println(sql);
			
			
			%><script>alert('구매가 완료되었습니다.');
			location.href="ctmMagicBuy.jsp";
			</script>
			<%
			
			
			
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