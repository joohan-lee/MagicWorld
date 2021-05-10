<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
    
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
<title>wizardMyMagicView</title>
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
	table, th, tr, td{
		border:1px solid black;
		border-collapse:collapse;
		text-align:center;
	}
	strong{
		background-color:cyan;
	}
</style>

<script>
function popup(str){
    var url = "popupMaterialInfo.jsp?mtid="+str;
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open(url, name, option);
}
</script>

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
	
	String mId = null;
	String mName = null;
	String mDescription = null;
	int mClass=-1;
	String mAttribute = null;
	String mType = null;
	int mEffectiveness = -1;
	int mMana_consumption = -1;
	int mPrice = -1;
	String mMaterial = null;	

%>


	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li><a href="wizardMaterialRegit.jsp">새로운 재료 등록</a></li>
			<li><a href="wizardMagicRegit.jsp">새로운 마법 등록</a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="wizardMyInfoView.jsp">확인</a></li>
					<li><a href="wizardMyInfoModify.jsp">수정</a></li>
				</ul>
			<li>나의 창조한 마법</li>
				<ul>
					<li><a href="wizardMyMagicView.jsp"><strong>확인</strong></a></li>
					<li><a href="wizardMyMagicModify.jsp">수정</a></li>
				</ul>
			<li><a href="wizardMyMagicTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
	
	<form method="get" action="wizardMyMagicView.jsp">
		<select name="searchRule" id="searchRule">
			<option>마법이름</option>
			<option>마법클래스</option>
			<option>마법종류</option>
		</select>
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
	</form>
		<table>
	  		<thead>
				<tr>
     		    	<th>마법ID</th>
					<th>이름</th>
					<th>설명</th>
					<th>클래스</th>
					<th>속성</th>
					<th>종류</th>
					<th>효과량</th>
					<th>마나소비량</th>
					<th>판매가격</th>
					<th>사용재료</th>
					<th></th>
				</tr>
			</thead>
   				
   			<tbody>
   				<%
   				if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
   					sql ="select * from magics where WizardID = '" + userId + "';";
   					rs = stmt.executeQuery(sql);

   				while(rs.next()){
   					mId = rs.getString("MagicID");
   					mName = rs.getString("Name");
   					mDescription = rs.getString("Description");
   					mClass= rs.getInt("Class");
   					mAttribute = rs.getString("Attribute");
   					mType = rs.getString("Type");
   					mEffectiveness = rs.getInt("Effectiveness");
   					mMana_consumption = rs.getInt("Mana_consumption");
   					mPrice = rs.getInt("Price");
   					
   					String sql2 = "select * from requisites where MagicID = '"+mId+"'";
   					rs2=stmt.executeQuery(sql2);
   					if(rs2.next()){
   						mMaterial = rs2.getString("MaterialID");
   					}

   				%>
				<tr>
					<td><%=mId %></td>
					<td><%=mName %></td>
					<td><%=mDescription %></td>
					<td><%=mClass %></td>
					<td><%=mAttribute %></td>
					<td><%=mType %></td>
					<td><%=mEffectiveness %></td>
					<td><%=mMana_consumption %></td>
					<td><%=mPrice %></td>
					<td><a href="javascript:popup(<%=mMaterial%>)"><%=mMaterial %></td>
					<td><input type="button" value="수정" onclick="location.href='wizardMyMagicModify.jsp?mId=<%=mId %>'"></td>
				</tr>
				<%
				}
				
   				}//if(search조건 없을 때)
   				else{//search 조건 있을 때, 3가지경우
   					if(searchRule.equals("마법이름")){
   	   					sql ="select * from magics where WizardID = '" + userId + "' and Name like '%"+searchStr+"%';";
   						rs = stmt.executeQuery(sql);

   		   				while(rs.next()){
   		   					mId = rs.getString("MagicID");
   		   					mName = rs.getString("Name");
   		   					mDescription = rs.getString("Description");
   		   					mClass= rs.getInt("Class");
   		   					mAttribute = rs.getString("Attribute");
   		   					mType = rs.getString("Type");
   		   					mEffectiveness = rs.getInt("Effectiveness");
   		   					mMana_consumption = rs.getInt("Mana_consumption");
   		   					mPrice = rs.getInt("Price");
   		   					
   		   					String sql2 = "select * from requisites where MagicID = '"+mId+"'";
   		   					rs2=stmt.executeQuery(sql2);
   		   					if(rs2.next()){
   		   						mMaterial = rs2.getString("MaterialID");
   		   					}

   		   				%>
   						<tr>
   							<td><%=mId %></td>
   							<td><%=mName %></td>
   							<td><%=mDescription %></td>
   							<td><%=mClass %></td>
   							<td><%=mAttribute %></td>
   							<td><%=mType %></td>
   							<td><%=mEffectiveness %></td>
   							<td><%=mMana_consumption %></td>
   							<td><%=mPrice %></td>
   							<td><a href="javascript:popup(<%=mMaterial%>)"><%=mMaterial %></a></td>
   							<td><input type="button" value="수정" onclick="location.href='wizardMyMagicModify.jsp?mId=<%=mId %>'"></td>
   							
   						</tr>
   						<%
   						}
   				
   					}//마법이름 경우
   					else if(searchRule.equals("마법클래스")){
   						sql ="select * from magics where WizardID = '" + userId + "' and Class ="+searchStr+ ";";
   						rs = stmt.executeQuery(sql);

   		   				while(rs.next()){
   		   					mId = rs.getString("MagicID");
   		   					mName = rs.getString("Name");
   		   					mDescription = rs.getString("Description");
   		   					mClass= rs.getInt("Class");
   		   					mAttribute = rs.getString("Attribute");
   		   					mType = rs.getString("Type");
   		   					mEffectiveness = rs.getInt("Effectiveness");
   		   					mMana_consumption = rs.getInt("Mana_consumption");
   		   					mPrice = rs.getInt("Price");
   		   					
   		   					String sql2 = "select * from requisites where MagicID = '"+mId+"'";
   		   					rs2=stmt.executeQuery(sql2);
   		   					if(rs2.next()){
   		   						mMaterial = rs2.getString("MaterialID");
   		   					}

   		   				%>
   						<tr>
   							<td><%=mId %></td>
   							<td><%=mName %></td>
   							<td><%=mDescription %></td>
   							<td><%=mClass %></td>
   							<td><%=mAttribute %></td>
   							<td><%=mType %></td>
   							<td><%=mEffectiveness %></td>
   							<td><%=mMana_consumption %></td>
   							<td><%=mPrice %></td>
   							<td><a href="javascript:popup(<%=mMaterial%>)"><%=mMaterial %></td>
   							<td><input type="button" value="수정" onclick="location.href='wizardMyMagicModify.jsp?mId=<%=mId %>'"></td>
   							
   						</tr>
   						<%
   						}
   					}//마법클래스 검색경우
   					else if(searchRule.equals("마법종류")){
   						sql ="select * from magics where WizardID = '" + userId + "' and Type ='"+searchStr+ "';";
   						rs = stmt.executeQuery(sql);

   		   				while(rs.next()){
   		   					mId = rs.getString("MagicID");
   		   					mName = rs.getString("Name");
   		   					mDescription = rs.getString("Description");
   		   					mClass= rs.getInt("Class");
   		   					mAttribute = rs.getString("Attribute");
   		   					mType = rs.getString("Type");
   		   					mEffectiveness = rs.getInt("Effectiveness");
   		   					mMana_consumption = rs.getInt("Mana_consumption");
   		   					mPrice = rs.getInt("Price");
   		   					
   		   					String sql2 = "select * from requisites where MagicID = '"+mId+"'";
   		   					rs2=stmt.executeQuery(sql2);
   		   					if(rs2.next()){
   		   						mMaterial = rs2.getString("MaterialID");
   		   					}

   		   				%>
   						<tr>
   							<td><%=mId %></td>
   							<td><%=mName %></td>
   							<td><%=mDescription %></td>
   							<td><%=mClass %></td>
   							<td><%=mAttribute %></td>
   							<td><%=mType %></td>
   							<td><%=mEffectiveness %></td>
   							<td><%=mMana_consumption %></td>
   							<td><%=mPrice %></td>
   							<td><a href="javascript:popup(<%=mMaterial%>)"><%=mMaterial %></a></td>
   							<td><input type="button" value="수정" onclick="location.href='wizardMyMagicModify.jsp?mId=<%=mId %>'"></td>
   						</tr>
   						<%
   						}
   					}//마법종류 검색경우
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