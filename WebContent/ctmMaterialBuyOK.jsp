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
<title>ctmMaterialBuyOK</title>
</head>
<body>
<%
		int materialId = Integer.parseInt(request.getParameter("materialId"));
		String shopId = request.getParameter("shopId");
		int buy_stock = Integer.parseInt(request.getParameter("input_stock"));
		int mtPrice = Integer.parseInt(request.getParameter("materialPrice"));
		
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
					
			//재고량과 본인 소지금 확인 후 크면 팔고, 부족하면 return
			int curStock = -1;
			int curBal=-1;
			sql = "select * from sales where ShopID= '"+shopId+"' and MaterialID='"+materialId+"';";
			rs =stmt.executeQuery(sql);
			if(rs.next()){
				curStock = rs.getInt("Stock");
			}
			sql = "select * from customers where CustomerID='"+userId+"';";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				curBal = rs.getInt("Balance");
			}
			if(curStock>=buy_stock&&curBal>=buy_stock*mtPrice){
				//재고량 차감
				sql = "update sales set stock = stock - "+buy_stock+" where ShopID ='"+shopId+"' and MaterialID='"+materialId+"';";
				stmt.executeUpdate(sql);
				//고객 소지금 차감
				sql = "update customers set balance = balance - "+buy_stock*mtPrice+" where CustomerID = '"+userId+"';";
				stmt.executeUpdate(sql);
				//마법상회 소지금 증가.
				sql = "update shops set shopbalance = shopbalance + "+buy_stock*mtPrice+" where ShopID='"+ shopId+"';";
				stmt.executeUpdate(sql);
				

				%><script>alert('구매가 완료되었습니다.');
				location.href="ctmMaterialBuy.jsp";
				</script>
				<%
			}else{
				if(!(curStock>=buy_stock)&&curBal>=buy_stock*mtPrice){
				%><script>alert('재고가 부족합니다.');
				history.go(-1);
				</script>
				<%
				}else if(!(curBal>=buy_stock*mtPrice)&&curStock>=buy_stock){
					%><script>alert('내 소지금 잔고가 부족합니다.');
					history.go(-1);
					</script>
					<%
				}else{
					%><script>alert('내 소지금 잔고와 재고 모두 부족합니다.');
					history.go(-1);
					</script>
					<%
				}
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