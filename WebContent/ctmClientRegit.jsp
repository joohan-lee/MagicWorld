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
<title>ctmClientRegit</title>
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
		background-color:white;
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
	String sql2=null;
	
	String sShopid = null;
	String sShopname = null;
	String sAddress = null;
	String sChiefname = null;
	int sPermitclass = -1;
	int sShopbalance = -1;
	
%>


	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>거래처</li>
				<ul>
					<li><a href="ctmClientRegit.jsp"><strong>등록</strong></a></li>
					<li><a href="ctmClientDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="ctmMagicBuy.jsp">마법구매</a></li>
			<li><a href="ctmMaterialBuy.jsp">재료구매</a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="ctmMyInfoView.jsp">확인</a></li>
					<li><a href="ctmMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="ctmMyTrans.jsp">내 거래내역</a></li>
			<li><a href="ctmMyMagicView.jsp">구매한 마법</a></li>			
		</ul>
	</div>
	
	<div id="container">
		<form method="get" action="ctmClientRegit.jsp">
		<select name="searchRule" id="searchRule">
			<option>상호</option>
			<option>주소</option>			
			<option>대표자이름</option>
			<option>거래허가클래스</option>
		</select>
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
	</form>
		<table>
		<caption>모든 마법상회 목록</caption>
	  		<thead>
				<tr>
     		    	<th>마법상회ID</th>
					<th>상호</th>
					<th>주소</th>
					<th>대표자이름</th>
					<th>거래허가클래스</th>
					<th>소지금</th>
					<th>거래여부</th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%
   				if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
   					sql ="select * from shops;";
   					rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					sShopid = rs.getString("ShopID");
   					sShopname = rs.getString("ShopName");
   					sAddress = rs.getString("Address");
   					sChiefname = rs.getString("ChiefName");
   					sPermitclass = rs.getInt("PermitClass");
   					sShopbalance = rs.getInt("ShopBalance");
   					
   					boolean regitPossible = true;
   					sql2= "select * from clients;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String cid = rs2.getString("CustomerID");
   						if(sid.equals(sShopid)&&cid.equals(userId)){
   							regitPossible = false;
   						}
   					}
   				%>
				<tr>
					<td><%=sShopid %></td>
					<td><%=sShopname %></td>
					<td><%=sAddress %></td>
					<td><%=sChiefname %></td>
					<td><%=sPermitclass %></td>
					<td><%=sShopbalance %></td>
					<td>
					<%if(regitPossible==true){%>
					<input type="button" value="거래등록" onclick="location.href='ctmClientRegitOK.jsp?shopId=<%=sShopid%>'" 
					style="cursor:pointer;">
					<%} else{ out.print("내 거래처");}
					%>
					</td>
				</tr>
				<%
				}//while(rs)
				
   				}//if(search조건 없을 때)
   				else{//search 조건 있을 때, 4가지경우
   					if(searchRule.equals("상호")){
   						sql ="select * from shops where ShopName like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					sShopid = rs.getString("ShopID");
   	   					sShopname = rs.getString("ShopName");
   	   					sAddress = rs.getString("Address");
   	   					sChiefname = rs.getString("ChiefName");
   	   					sPermitclass = rs.getInt("PermitClass");
   	   					sShopbalance = rs.getInt("ShopBalance");
   	   					
   	   				%>
   					<tr>
   						<td><%=sShopid %></td>
   						<td><%=sShopname %></td>
   						<td><%=sAddress %></td>
   						<td><%=sChiefname %></td>
   						<td><%=sPermitclass %></td>
   						<td><%=sShopbalance %></td>
   						<td>
   						<input type="button" value="거래등록" onclick="location.href='ctmClientRegitOK.jsp?shopId=<%=sShopid%>'" 
   						style="cursor:pointer;">
   						</td>
   					</tr>
   					<%
   					}
   				
   					}//마법상회주소 검색 경우
   					else if(searchRule.equals("주소")){
   						sql ="select * from shops where Address like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					sShopid = rs.getString("ShopID");
   	   					sShopname = rs.getString("ShopName");
   	   					sAddress = rs.getString("Address");
   	   					sChiefname = rs.getString("ChiefName");
   	   					sPermitclass = rs.getInt("PermitClass");
   	   					sShopbalance = rs.getInt("ShopBalance");
   	   					
   	   				%>
   					<tr>
   						<td><%=sShopid %></td>
   						<td><%=sShopname %></td>
   						<td><%=sAddress %></td>
   						<td><%=sChiefname %></td>
   						<td><%=sPermitclass %></td>
   						<td><%=sShopbalance %></td>
   						<td>
   						<input type="button" value="거래등록" onclick="location.href='ctmClientRegitOK.jsp?shopId=<%=sShopid%>'" 
   						style="cursor:pointer;">
   						</td>
   					</tr>
   					<%
   					}
   					}//상호 검색경우
   					else if(searchRule.equals("대표자이름")){
   						sql ="select * from shops where ChiefName ='"+searchStr+"'";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					sShopid = rs.getString("ShopID");
   	   					sShopname = rs.getString("ShopName");
   	   					sAddress = rs.getString("Address");
   	   					sChiefname = rs.getString("ChiefName");
   	   					sPermitclass = rs.getInt("PermitClass");
   	   					sShopbalance = rs.getInt("ShopBalance");
   	   					
   	   				%>
   					<tr>
   						<td><%=sShopid %></td>
   						<td><%=sShopname %></td>
   						<td><%=sAddress %></td>
   						<td><%=sChiefname %></td>
   						<td><%=sPermitclass %></td>
   						<td><%=sShopbalance %></td>
   						<td>
   						<input type="button" value="거래등록" onclick="location.href='ctmClientRegitOK.jsp?shopId=<%=sShopid%>'" 
   						style="cursor:pointer;">
   						</td>
   					</tr>
   					<%
   					}
   					}//대표자이름 검색경우
   					else if(searchRule.equals("거래허가클래스")){
   						sql ="select * from shops where PermitClass ="+searchStr;
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					sShopid = rs.getString("ShopID");
   	   					sShopname = rs.getString("ShopName");
   	   					sAddress = rs.getString("Address");
   	   					sChiefname = rs.getString("ChiefName");
   	   					sPermitclass = rs.getInt("PermitClass");
   	   					sShopbalance = rs.getInt("ShopBalance");
   	   					
   	   				%>
   					<tr>
   						<td><%=sShopid %></td>
   						<td><%=sShopname %></td>
   						<td><%=sAddress %></td>
   						<td><%=sChiefname %></td>
   						<td><%=sPermitclass %></td>
   						<td><%=sShopbalance %></td>
   						<td>
   						<input type="button" value="거래등록" onclick="location.href='ctmClientRegitOK.jsp?shopId=<%=sShopid%>'" 
   						style="cursor:pointer;">
   						</td>
   					</tr>
   					<%
   					}
   					}//거래허가클래스 검색경우
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