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
<title>wizardMagicRegit</title>
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
		width:600px;
		text-align:center;
		margin:20px;
	}
	table, tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
	}
	strong{
		background-color:cyan;
	}

</style>

</head>
<body>
<%
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
	String sql = "select * from wizards where WizardID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myAttr = null;
	int myClass=0;
	while(rs.next()){
		myAttr = rs.getString("Attribute");
		myClass = rs.getInt("Class");
	}
	
	sql = "select * from materials;";
	rs = stmt.executeQuery(sql);
	String materialId = null;
	%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li><a href="wizardMaterialRegit.jsp">새로운 재료 등록</a></li>
			<li><a href="wizardMagicRegit.jsp"><strong>새로운 마법 등록</strong></a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="wizardMyInfoView.jsp">확인</a></li>
					<li><a href="wizardMyInfoModify.jsp">수정</a></li>
				</ul>
			<li>나의 창조한 마법</li>
				<ul>
					<li><a href="wizardMyMagicView.jsp">확인</a></li>
					<li><a href="wizardMyMagicModify.jsp">수정</a></li>
				</ul>
			<li><a href="wizardMyMagicTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
		<form method="get" action="wizardMagicRegitOK.jsp" name="magicInput">
			<table>
			<caption>마법 정보 입력</caption>
				<tr>
					<th width="30%">ID</th>
					<td width="70%">
							자동배정
					</td>
				</tr>
				<tr>
					<th width="30%">이름</th>
					<td width="70%">
						<input type="text" name="input_name" id="input_name" maxlength="255" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">설명</th>
					<td width="70%">
						<input type="text" name="input_description" id="input_description" maxlength="255" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">클래스</th>
					<td width="70%">
						<input type="number" name="input_class" id="input_class" min="1" max="<%=myClass%>" required="">
						<br>(1에서 <%=myClass %>이하의 값 입력)
					</td>
				</tr>
				<tr>
					<th width="30%">속성</th>
					<td width="70%">
						<input type="text" name="input_attribute" id="input_attribute" value="<%=myAttr%>" readOnly="true"
						 style="border:none;text-align:center;">					
					</td>
				</tr>
				<tr>
					<th width="30%">종류(Type)</th>
					<td width="70%">
							<select name="input_typeSelect" id = "input_typeSelect">
								<option>attack</option>
								<option>defense</option>
								<option>heal</option>
								<option>support</option>
								<option>movement</option>
							</select>					
					</td>
				</tr>
				<tr>
					<th width="30%">효과량</th>
					<td width="70%">
						<input type="number" name="input_effectiveness" id="input_effectiveness" min="1" max="100" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">마나소비량</th>
					<td width="70%">
						<input type="number" name="input_mana_consumption" id="input_mana_consumption" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">가격</th>
					<td width="70%">
						<input type="number" name="input_price" id="input_price" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">창조자ID</th>
					<td width="70%">
						<%=userId %>
					</td>
				</tr>
			</table>
			<table style="margin-top:20px;">
				<caption>필요 재료 입력</caption>
				<tr>
					<th width="30%">MaterialID</th>
					<td width="70%">
						<select name="input_materialSelect" id="input_materialSelect">
							<%
							while(rs.next()){
								materialId = rs.getString("MaterialID");
								out.print("<option>"+materialId +"</option>");
							}
							 %>
						</select>
					</td>
				</tr>
				<tr>
					<th width="30%">필요량</th>
					<td width="70%">
						<input type="number" name="input_requisite" id="input_requisite" min="1" required="">
					</td>
				</tr>
			
			</table>
			<input type="submit" value="등록">
		</form>
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