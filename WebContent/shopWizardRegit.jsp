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
<title>shopWizardRegit</title>
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
	String sql2=null;
	
	String wId = null;
	String wName = null;
	int wAge = -1;
	String wTribe = null;
	String wHometown = null;
	String wOccupation = null;
	int wClass = -1;
	String wAttribute = null;
	int wMana = -1;
	int wBalance = -1;	

	int sPermitclass = -1;
	sql = "select * from shops where ShopId='"+userId+"';";
	rs=stmt.executeQuery(sql);
	if(rs.next()){
		sPermitclass = rs.getInt("PermitClass");
	}
	
%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>소속 마법사</li>
				<ul>
					<li><a href="shopWizardRegit.jsp"><strong>등록</strong></a></li>
					<li><a href="shopWizardDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="shopMaterialRegit.jsp">재료 재고 등록</a></li>
			<li>나의 마법상회 정보</li>
				<ul>
					<li><a href="shopMyInfoView.jsp">확인</a></li>
					<li><a href="shopMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="shopTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
		<form method="get" action="shopWizardRegit.jsp">
		<select name="searchRule" id="searchRule">
			<option>이름</option>
			<option>종족</option>
			<option>클래스</option>
			<option>속성</option>			
		</select>
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
		<p>본인허가클래스 : <%=sPermitclass %></p>
	</form>
		<table>
		<caption>모든 마법사 목록</caption>
	  		<thead>
				<tr>
     		    	<th>마법사ID</th>
					<th>이름</th>
					<th>나이</th>
					<th>종족</th>
					<th>출신지</th>
					<th>직업</th>
					<th>클래스</th>
					<th>속성</th>
					<th>마나</th>
					<th>소지금</th>
					<th></th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%
   				if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
   					sql ="select * from wizards;";
   					rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					wId = rs.getString("WizardID");
   					wName = rs.getString("Name");
   					wAge = rs.getInt("Age");
   					wTribe = rs.getString("Tribe");
   					wHometown = rs.getString("Hometown");
   					wOccupation = rs.getString("Occupation");
   					wClass = rs.getInt("Class");
   					wAttribute = rs.getString("Attribute");
   					wMana = rs.getInt("Mana");
   					wBalance =  rs.getInt("Balance");
   					
   					boolean regitPossible = true;
   					sql2= "select * from belongings;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String wid = rs2.getString("WizardID");
   						if(sid.equals(userId)&&wid.equals(wId)){
   							regitPossible = false;
   						}
   					}
   					
   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					<td>
					<%
					if(regitPossible==true){
					if(wClass <= sPermitclass){ %>
					<input type="button" value="등록하기" onclick="location.href='shopWizardRegitOK.jsp?wId=<%=wId%>'" 
					style="cursor:pointer;">
					<%} else{out.print("등록불가");}
						
					}else{
						out.print("이미등록");
					}
					%>
					</td>
				</tr>
				<%
				}
				
   				}//if(search조건 없을 때)
   				else{//search 조건 있을 때, 4가지경우
   					if(searchRule.equals("이름")){
   						sql ="select * from wizards where Name like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					wId = rs.getString("WizardID");
   	   					wName = rs.getString("Name");
   	   					wAge = rs.getInt("Age");
   	   					wTribe = rs.getString("Tribe");
   	   					wHometown = rs.getString("Hometown");
   	   					wOccupation = rs.getString("Occupation");
   	   					wClass = rs.getInt("Class");
   	   					wAttribute = rs.getString("Attribute");
   	   					wMana = rs.getInt("Mana");
   	   					wBalance =  rs.getInt("Balance");
   	   					
   	   				boolean regitPossible = true;
   					sql2= "select * from belongings;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String wid = rs2.getString("WizardID");
   						if(sid.equals(userId)&&wid.equals(wId)){
   							regitPossible = false;
   						}
   					}
   					
   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					<td>
					<%
					if(regitPossible==true){
					if(wClass <= sPermitclass){ %>
					<input type="button" value="등록하기" onclick="location.href='shopWizardRegitOK.jsp?wId=<%=wId%>'" 
					style="cursor:pointer;">
					<%} else{out.print("등록불가");}
						
					}else{
						out.print("이미등록");
					}
					%>
					</td>
				</tr>
				<%
				}
   				
   					}//마법사이름 경우
   					else if(searchRule.equals("종족")){
   						sql ="select * from wizards where Tribe like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					wId = rs.getString("WizardID");
   	   					wName = rs.getString("Name");
   	   					wAge = rs.getInt("Age");
   	   					wTribe = rs.getString("Tribe");
   	   					wHometown = rs.getString("Hometown");
   	   					wOccupation = rs.getString("Occupation");
   	   					wClass = rs.getInt("Class");
   	   					wAttribute = rs.getString("Attribute");
   	   					wMana = rs.getInt("Mana");
   	   					wBalance =  rs.getInt("Balance");
   	   					
   	   				boolean regitPossible = true;
   					sql2= "select * from belongings;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String wid = rs2.getString("WizardID");
   						if(sid.equals(userId)&&wid.equals(wId)){
   							regitPossible = false;
   						}
   					}
   					
   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					<td>
					<%
					if(regitPossible==true){
					if(wClass <= sPermitclass){ %>
					<input type="button" value="등록하기" onclick="location.href='shopWizardRegitOK.jsp?wId=<%=wId%>'" 
					style="cursor:pointer;">
					<%} else{out.print("등록불가");}
						
					}else{
						out.print("이미등록");
					}
					%>
					</td>
				</tr>
				<%
				}
   					}//마법사종족 검색경우
   					else if(searchRule.equals("클래스")){
   						sql ="select * from wizards where Class = "+searchStr+";";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					wId = rs.getString("WizardID");
   	   					wName = rs.getString("Name");
   	   					wAge = rs.getInt("Age");
   	   					wTribe = rs.getString("Tribe");
   	   					wHometown = rs.getString("Hometown");
   	   					wOccupation = rs.getString("Occupation");
   	   					wClass = rs.getInt("Class");
   	   					wAttribute = rs.getString("Attribute");
   	   					wMana = rs.getInt("Mana");
   	   					wBalance =  rs.getInt("Balance");
   	   					
   	   				boolean regitPossible = true;
   					sql2= "select * from belongings;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String wid = rs2.getString("WizardID");
   						if(sid.equals(userId)&&wid.equals(wId)){
   							regitPossible = false;
   						}
   					}
   					
   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					<td>
					<%
					if(regitPossible==true){
					if(wClass <= sPermitclass){ %>
					<input type="button" value="등록하기" onclick="location.href='shopWizardRegitOK.jsp?wId=<%=wId%>'" 
					style="cursor:pointer;">
					<%} else{out.print("등록불가");}
						
					}else{
						out.print("이미등록");
					}
					%>
					</td>
				</tr>
				<%
				}
   					}//마법사클래스 검색경우
   					else if(searchRule.equals("속성")){
   						sql ="select * from wizards where Attribute like '%"+searchStr+"%';";
   	   					rs = stmt.executeQuery(sql);

   	   				while(rs.next()){
   	   					wId = rs.getString("WizardID");
   	   					wName = rs.getString("Name");
   	   					wAge = rs.getInt("Age");
   	   					wTribe = rs.getString("Tribe");
   	   					wHometown = rs.getString("Hometown");
   	   					wOccupation = rs.getString("Occupation");
   	   					wClass = rs.getInt("Class");
   	   					wAttribute = rs.getString("Attribute");
   	   					wMana = rs.getInt("Mana");
   	   					wBalance =  rs.getInt("Balance");
   	   					
   	   				boolean regitPossible = true;
   					sql2= "select * from belongings;";
   					rs2=stmt.executeQuery(sql2);
   					while(rs2.next()){
   						String sid = rs2.getString("ShopID");
   						String wid = rs2.getString("WizardID");
   						if(sid.equals(userId)&&wid.equals(wId)){
   							regitPossible = false;
   						}
   					}
   					
   				%>
				<tr>
					<td><%=wId %></td>
					<td><%=wName %></td>
					<td><%=wAge %></td>
					<td><%=wTribe %></td>
					<td><%=wHometown %></td>
					<td><%=wOccupation %></td>
					<td><%=wClass %></td>
					<td><%=wAttribute %></td>
					<td><%=wMana %></td>
					<td><%=wBalance %></td>
					<td>
					<%
					if(regitPossible==true){
					if(wClass <= sPermitclass){ %>
					<input type="button" value="등록하기" onclick="location.href='shopWizardRegitOK.jsp?wId=<%=wId%>'" 
					style="cursor:pointer;">
					<%} else{out.print("등록불가");}
						
					}else{
						out.print("이미등록");
					}
					%>
					</td>
				</tr>
				<%
				}
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