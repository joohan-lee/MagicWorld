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
<title>ctmMagicBuy2</title>
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
	
	String mId = null;
	String mName = null;
	String mDescription = null;
	int mClass=-1;
	String mAttribute = null;
	String mType = null;
	int mEffectiveness = -1;
	int mMana_consumption = -1;
	int mPrice = -1;
	String mWizardid = null;
	
	String mMaterialid=null;
	
	%>
	
	<form method="get" action="ctmMagicBuy2.jsp">
		<select name="searchRule" id="searchRule">
			<option>마법이름</option>
			<option>마법클래스</option>
			<option>마법종류</option>
		</select>
		<input type="hidden" name="shopId" id="shopId" value="<%=shopId %>">
		<input type="text" name="searchStr" id="searchStr" value="<%if(searchStr!=null){out.print(searchStr);}%>">
		<input type="submit" value="검색">
	</form>
	
	<table>
	<caption>선택한 마법상회(<%=shopId %>)의 판매 마법목록</caption>
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
				<th>선택</th>
			</tr>
		</thead>
		<tbody>
		
	<%
	if(searchRule==null||searchStr==null||searchRule.equals("")||searchStr.equals("")){
	//판매,필요,마법 테이블 조인하여 해당 상회의 마법id들의 마법목록 뽑아냄.
	sql = "select * from sales, requisites,magics where sales.MaterialID = requisites.MaterialID AND sales.ShopID ='"+shopId+"'"
	+" and requisites.MagicID = magics.MagicID;";
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
		mWizardid = rs.getString("WizardID");
		mMaterialid = rs.getString("MaterialID");
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
				<td><input type="button" value="구매" style="cursor:pointer;"
				onclick="location.href='ctmMagicBuyOK.jsp?magicId=<%=mId%>&materialId=<%=mMaterialid%>&shopId=<%=shopId%>&magicAttr=<%=mAttribute%>&magicWizid=<%=mWizardid%>'"></td>
			</tr>
		<%
		}//while
	}//if(search조건없을떄)
	else{//search조건 있을 때, 3가지경우
		if(searchRule.equals("마법이름")){
			sql = "select * from sales, requisites,magics where sales.MaterialID = requisites.MaterialID AND sales.ShopID ='"+shopId+"'"
					+" and requisites.MagicID = magics.MagicID and Name like '%"+searchStr+"%';";
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
						mMaterialid = rs.getString("MaterialID");
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
								<td><input type="button" value="구매" 
								onclick="location.href='ctmMagicBuyOK.jsp?magicId=<%=mId%>&materialId=<%=mMaterialid%>'"></td>
							</tr>
						<%
						}//while
		
			}//마법이름 경우
			else if(searchRule.equals("마법클래스")){
				sql = "select * from sales, requisites,magics where sales.MaterialID = requisites.MaterialID AND sales.ShopID ='"+shopId+"'"
						+" and requisites.MagicID = magics.MagicID and Class="+searchStr;
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
							mMaterialid = rs.getString("MaterialID");
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
									<td><input type="button" value="구매" 
									onclick="location.href='ctmMagicBuyOK.jsp?magicId=<%=mId%>&materialId=<%=mMaterialid%>'"></td>
								</tr>
							<%
							}//while
			}//마법클래스 검색경우
			else if(searchRule.equals("마법종류")){
				sql = "select * from sales, requisites,magics where sales.MaterialID = requisites.MaterialID AND sales.ShopID ='"+shopId+"'"
						+" and requisites.MagicID = magics.MagicID and Type ='"+searchStr+"';";
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
							mMaterialid = rs.getString("MaterialID");
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
									<td><input type="button" value="구매" 
									onclick="location.href='ctmMagicBuyOK.jsp?magicId=<%=mId%>&materialId=<%=mMaterialid%>'"></td>
								</tr>
							<%
							}//while
			}//마법종류 검색경우
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