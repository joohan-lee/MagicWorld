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
<title>wizardMyInfoModify</title>
<script>
function checkPw(){
	var pw = document.getElementById("input_pw1").value;
	var pw_ck = document.getElementById("input_pw2").value;
	
	if(pw !='' && pw_ck != ''){
		if(pw==pw_ck){
			document.getElementById('pwsame').innerHTML = '비밀번호가 일치합니다.';
			document.getElementById('pwsame').style.color = 'blue';
		}
	}
	if(pw!=pw_ck){
		document.getElementById('pwsame').innerHTML = '비밀번호가 다릅니다. 다시 입력해주세요';
		document.getElementById('pwsame').style.color = 'red';
		return false;
	}
}
</script>
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
		text-align:center;
		padding-top:30px;
		padding-left:30px;
	}
	tr, th, td{
		border:1px solid black;
		border-collapse:collapse;
		text-align:center;
	}
	strong{
		background-color:pink;
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
	String sql = "select * from shops where ShopID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myShopname = null;
	String myAddress = null;
	String myChiefname = null;
	int myPermitclass = -1;
	int myShopbalance = -1;
	
	while(rs.next()){
		myShopname = rs.getString("ShopName");
		myAddress = rs.getString("Address");
		myChiefname = rs.getString("ChiefName");
		myPermitclass = rs.getInt("PermitClass");
		myShopbalance = rs.getInt("ShopBalance");

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
			<li><a href="shopMaterialRegit.jsp">재료 재고 등록</a></li>
			<li>나의 마법상회 정보</li>
				<ul>
					<li><a href="shopMyInfoView.jsp">확인</a></li>
					<li><a href="shopMyInfoModify.jsp"><strong>수정</strong></a></li>
				</ul>
			<li><a href="shopTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
		
	<div id="container">
			<form method="post" action="shopMyInfoModifyOK.jsp" name="shopMyInfoInput">
			<table>
			<caption>내 마법상회 정보 수정</caption>
				<tr>
					<th width="30%">아이디</th>

					<td width="70%">
						<%=userId %>
					</td>
				</tr>
				<tr>
					<th width="30%">패스워드</th>
					<td width="70%">
							<input type="password" name="input_pw1" id="input_pw1" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">패스워드 확인</th>
					<td width="70%">
						<input type="password" name="input_pw2" id="input_pw2" onchange="checkPw()" required="">
					</td>
					<td>
						<p id="pwsame" onchange=></p>
					</td>
				</tr>
				<tr>
					<th width="30%">가게 이름</th>
					<td width="70%">
						<input type="text" name="input_name" id="input_name" value="<%=myShopname %>" maxlength="255" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">주소</th>
					<td width="70%">
						<input type="text" name="input_address" id="input_address" value="<%=myAddress %>" maxlength="255" required="">					
					</td>
				</tr>
				<tr>
					<th width="30%">대표자이름</th>
					<td width="70%">	
						<input type="text" name="input_chiefname" id="input_chiefname" value="<%=myChiefname %>" maxlength="255" required="">					
					</td>
				</tr>
				<tr>
					<th width="30%">거래허가 클래스</th>
					<td width="70%">
						<%=myPermitclass %>
					</td>
				</tr>
				<tr>
					<th width="30%">소지금</th>
					<td width="70%">
							<input type="number" name="input_shopbalance" id="input_shopbalance" value = "<%=myShopbalance %>">
					</td>
				</tr>
			</table>
			<input type="submit" value="수정"
				style="margin-left: auto; margin-right: auto;">
		</form>
	</div>

<%
	}//while
	}catch(Exception e){
	e.printStackTrace();
	}finally{
	try{
		if(rs!=null) {rs.close();}
		if(stmt!=null) {stmt.close();}
		if(conn!=null) {conn.close();}
	}catch(SQLException e){
		e.printStackTrace();
	}
	}

%>

</body>
</html>