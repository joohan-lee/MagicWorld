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
<title>shopMaterialRegit</title>
<style>
	#header{
		width:100%;
		background-color:cyan;
		color:gray;
		float:left;
		text-align:right;
	}
	#nav{
		width:200px;
		float:left;
		background-color:yellow;
	}
	#container{
		float:left;
		width:800px;
	}
	table, tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
	}
	strong{
		background-color:pink;
	}

</style>

</head>
<body>
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
	String sql2 = null;
	
	String mtId = null;
	String mtName = null;
	String mtOrigin = null;
	String mtType = null;
	int mtPrice = -1;
	
%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>소속 마법사</li>
				<ul>
					<li><a href="shopWizardRegit.jsp">등록</a></li>
					<li><a href="shopWizardDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="shopMaterialRegit.jsp"><strong>재료 재고 등록</strong></a></li>
			<li>나의 마법상회 정보</li>
				<ul>
					<li><a href="shopMyInfoView.jsp">확인</a></li>
					<li><a href="shopMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="shopTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
		<form method="get" action="shopMaterialRegit.jsp">
		<select name="searchRule" id="searchRule">
			<option>이름</option>
			<option>원산지</option>
			<option>종류</option>
			<option>가격(조건이하)</option>			
		</select>
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
	</form>
		<table>
		<caption>전체 재료 목록</caption>
	  		<thead>
				<tr>
     		    	<th>재료ID</th>
					<th>이름</th>
					<th>원산지</th>
					<th>종류</th>
					<th>가격</th>
					<th>재고량</th>
					<th>등록/추가</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%
   				if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
   					sql ="select * from materials;";
   					rs = stmt.executeQuery(sql);
   				while(rs.next()){
   					mtId = rs.getString("MaterialID");
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
					<form method="get" action="shopMaterialRegitOK.jsp">
					<td><input type="number" min="1" name="input_stock" id="input_stock" required=""></td>
					<td>
					<input type="hidden" value="<%=mtPrice %>" name="mtPrice" id="mtPrice">
					<input type="hidden" value="<%=mtId %>" name="mtId" id="mtId">
					<input type="submit" value="재고등록" style="cursor:pointer;">
					</td>
					</form>
				</tr>
				<%
				}//while(rs)
   								
   				}//if(search조건 없을 때)
   				else{//search 조건 있을 때, 4가지경우
   					if(searchRule.equals("이름")){
   						sql ="select * from materials where Name like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);
   	   				while(rs.next()){
   	   					mtId = rs.getString("MaterialID");
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
   						<form method="get" action="shopMaterialRegitOK.jsp">
   						<td><input type="number" min="1" name="input_stock" id="input_stock"></td>
   						<td>
  						<input type="hidden" value="<%=mtPrice %>" name="mtPrice" id="mtPrice">
   						<input type="hidden" value="<%=mtId %>" name="mtId" id="mtId">
   						<input type="submit" value="재고등록" style="cursor:pointer;">
   						</td>
   						</form>
   					</tr>
   					<%
   					}//while(rs)
   				
   					}//재료이름 검색 경우
   					else if(searchRule.equals("원산지")){
   						sql ="select * from materials where Origin like '%"+searchStr +"%';";
   	   					rs = stmt.executeQuery(sql);
   	   				while(rs.next()){
   	   					mtId = rs.getString("MaterialID");
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
   						<form method="get" action="shopMaterialRegitOK.jsp">
   						<td><input type="number" min="1" name="input_stock" id="input_stock"></td>
   						<td>
   						<input type="hidden" value="<%=mtPrice %>" name="mtPrice" id="mtPrice">
   						<input type="hidden" value="<%=mtId %>" name="mtId" id="mtId">
   						<input type="submit" value="재고등록" style="cursor:pointer;">
   						</td>
   						</form>
   					</tr>
   					<%
   					}//while(rs)
   					}//재료원산지 검색경우
   					else if(searchRule.equals("종류")){
   						sql ="select * from materials where Type like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);
   	   				while(rs.next()){
   	   					mtId = rs.getString("MaterialID");
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
   						<form method="get" action="shopMaterialRegitOK.jsp">
   						<td><input type="number" min="1" name="input_stock" id="input_stock"></td>
   						<td>
   						<input type="hidden" value="<%=mtPrice %>" name="mtPrice" id="mtPrice">
   						<input type="hidden" value="<%=mtId %>" name="mtId" id="mtId">
   						<input type="submit" value="재고등록" style="cursor:pointer;">
   						</td>
   						</form>
   					</tr>
   					<%
   					}//while(rs)
   					}//재료종류 검색경우
   					else if(searchRule.equals("가격(조건이하)")){
   						sql ="select * from materials where Price <=" + searchStr +";";
   	   					rs = stmt.executeQuery(sql);
   	   				while(rs.next()){
   	   					mtId = rs.getString("MaterialID");
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
   						<form method="get" action="shopMaterialRegitOK.jsp">
   						<td><input type="number" min="1" name="input_stock" id="input_stock"></td>
   						<td>
   						<input type="hidden" value="<%=mtPrice %>" name="mtPrice" id="mtPrice">
   						<input type="hidden" value="<%=mtId %>" name="mtId" id="mtId">
   						<input type="submit" value="재고등록" style="cursor:pointer;">
   						</td>
   						</form>
   					</tr>
   					<%
   					}//while(rs)
   					}//마법사속성 검색경우
   					else{
   						out.print("검색경우오류");
   					}
   				}
   				%>
				
			</tbody>
		</table>
	</div>

<%

	}catch(Exception e){
	e.printStackTrace();
	}finally{
	try{
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
	}

%>

</body>
</html>