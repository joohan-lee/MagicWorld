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
<%String shopId = request.getParameter("shopId"); %>
<html>
<head>
<meta charset="utf-8">
<title>ctmMaterialBuy2</title>
<style>
table, th, tr, td{
		border:1px solid black;
		border-collapse:collapse;
		text-align:center;
	}
</style>
</head>
<body>
<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
</div>
<%
String searchRule = request.getParameter("searchRule");
String searchStr = request.getParameter("searchStr");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

String jdbcDriver = "jdbc:mariadb://localhost:3306/magicworld";
String dbUser = "root";
String dbPass = "8787";

try{
	conn = DriverManager.getConnection(jdbcDriver, dbUser,dbPass);
	stmt = conn.createStatement();
	String sql = null;
	String sql2=null;
	
	int mtId = -1;
	String mtName = null;
	String mtOrigin = null;
	String mtType = null;
	int mtPrice = -1;
	int mtStock =-1;
		
	%>
	
	<form method="get" action="ctmMaterialBuy2.jsp">
		<select name="searchRule" id="searchRule">
			<option>이름</option>
			<option>원산지</option>
			<option>종류</option>
		</select>
		<input type="hidden" name="shopId" id="shopId" value="<%=shopId %>">
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
	</form>
	
	<table>
	<caption>선택한 마법상회(<%=shopId %>)의 판매 재료목록</caption>
		<thead>
			<tr>
				<th>재료ID</th>
				<th>이름</th>
				<th>원산지</th>
				<th>종류</th>
				<th>가격</th>
				<th>재고량</th>
				<th>구매수량</th>
				<th>구매</th>
			</tr>
		</thead>
		<tbody>
		
	<%
	if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
	//판매,필요,마법 테이블 조인하여 해당 상회의 마법id들의 마법목록 뽑아냄.
	sql = "select * from sales, materials where sales.MaterialID = materials.MaterialID AND sales.ShopID ='"+shopId+"';";
	rs = stmt.executeQuery(sql);
	while(rs.next()){
		mtId = rs.getInt("MaterialID");
		mtName = rs.getString("Name");
		mtOrigin = rs.getString("Origin");
		mtType = rs.getString("Type");
		mtPrice = rs.getInt("Price");
		mtStock = rs.getInt("Stock");
		
		%>
			<tr>
				<td><%=mtId %></td>
				<td><%=mtName %></td>
				<td><%=mtOrigin %></td>
				<td><%=mtType %></td>
				<td><%=mtPrice %></td>
				<td><%=mtStock %></td>
				<form method="get" action="ctmMaterialBuyOK.jsp">
				<td><input type="number" min="1" name="input_stock" id="input_stock" required=""></td>
				<td>
				<input type="hidden" value="<%=mtId %>" name="materialId" id="materialId">
				<input type="hidden" value="<%=shopId %>" name="shopId" id="shopId">
				<input type="hidden" value="<%=mtPrice %>" name="materialPrice" id="materialPrice">
				<input type="submit" value="구매" style="cursor:pointer;"></td>
				</form>
			</tr>
		<%
		}//while
	}//if(search조건없을떄)
	else{//search조건 있을 때, 3가지경우
		if(searchRule.equals("이름")){
			sql = "select * from sales, materials where sales.MaterialID = materials.MaterialID AND sales.ShopID ='"+shopId+"' and Name = '"+searchStr+"';";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				mtId = rs.getInt("MaterialID");
				mtName = rs.getString("Name");
				mtOrigin = rs.getString("Origin");
				mtType = rs.getString("Type");
				mtPrice = rs.getInt("Price");
				%>
					<tr>
						<td><%=mtId %></td>
						<td><%=mtName %></td>
						<td><%=mtOrigin %></td>
						<td><%=mtType %></td>
						<td><%=mtPrice %></td>
						<td><input type="button" value="구매" style="cursor:pointer;"
						onclick="location.href='ctmMaterialBuyOK.jsp?materialId=<%=mtId%>&shopId=<%=shopId%>'"></td>
					</tr>
				<%
				}//while
		
			}//재료이름 경우
			else if(searchRule.equals("원산지")){
				sql = "select * from sales, materials where sales.MaterialID = materials.MaterialID AND sales.ShopID ='"+shopId+"' and Origin = '"+searchStr +"';";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					mtId = rs.getInt("MaterialID");
					mtName = rs.getString("Name");
					mtOrigin = rs.getString("Origin");
					mtType = rs.getString("Type");
					mtPrice = rs.getInt("Price");
					%>
						<tr>
							<td><%=mtId %></td>
							<td><%=mtName %></td>
							<td><%=mtOrigin %></td>
							<td><%=mtType %></td>
							<td><%=mtPrice %></td>
							<td><input type="button" value="구매" style="cursor:pointer;"
							onclick="location.href='ctmMaterialBuyOK.jsp?materialId=<%=mtId%>&shopId=<%=shopId%>'"></td>
						</tr>
					<%
					}//while
			}//재료원산지 검색경우
			else if(searchRule.equals("종류")){
				sql = "select * from sales, materials where sales.MaterialID = materials.MaterialID AND sales.ShopID ='"+shopId+"' and Type = '"+searchStr+"';";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					mtId = rs.getInt("MaterialID");
					mtName = rs.getString("Name");
					mtOrigin = rs.getString("Origin");
					mtType = rs.getString("Type");
					mtPrice = rs.getInt("Price");
					%>
						<tr>
							<td><%=mtId %></td>
							<td><%=mtName %></td>
							<td><%=mtOrigin %></td>
							<td><%=mtType %></td>
							<td><%=mtPrice %></td>
							<td><input type="button" value="구매" style="cursor:pointer;"
							onclick="location.href='ctmMaterialBuyOK.jsp?materialId=<%=mtId%>&shopId=<%=shopId%>'"></td>
						</tr>
					<%
					}//while
			}//재료종류 검색경우
			else{
				out.print("검색경우오류");
			}
	}//else(검색조건)
	%>
		</tbody>
	</table>
	<%
}catch(Exception e){
e.printStackTrace();
}finally{
try{
	if(rs!=null){rs.close();}
	if(stmt!=null){stmt.close();}
	if(conn!=null){conn.close();}
}catch(SQLException e){
	e.printStackTrace();
}
}

%>
</body>
</html>