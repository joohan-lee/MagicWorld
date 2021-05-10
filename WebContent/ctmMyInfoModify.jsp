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
<title>ctmMyInfoModify</title>
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
	String sql = "select * from customers where customerID = '" + userId + "';";
	rs = stmt.executeQuery(sql);
	
	String myName = null;
	int myAge = -1;
	String myAddress = null;
	String myAttribute = null;
	int myBalance = -1;
	
	while(rs.next()){
		myName = rs.getString("Name");
		myAge = rs.getInt("Age");
		myAddress = rs.getString("Address");
		myAttribute = rs.getString("Attribute");
		myBalance = rs.getInt("Balance");

%>

	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li>거래처</li>
				<ul>
					<li><a href="ctmClientRegit.jsp">등록</a></li>
					<li><a href="ctmClientDelete.jsp">삭제</a></li>
				</ul>
			<li><a href="ctmMagicBuy.jsp">마법구매</a></li>
			<li><a href="ctmMaterialBuy.jsp">재료구매</a></li>
			<li>내 정보</li>
				<ul>
					<li><a href="ctmMyInfoView.jsp">확인</a></li>
					<li><a href="ctmMyInfoModify.jsp"><strong>수정</strong></a></li>
				</ul>
			<li><a href="ctmMyTrans.jsp">내 거래내역</a></li>
			<li><a href="ctmMyMagicView.jsp">구매한 마법</a></li>			
		</ul>
	</div>
	
	<div id="container">
	<form method="post" action="ctmMyInfoModifyOK.jsp" name="ctmMyInfoInput">
		<table>
			<caption>내 정보</caption>
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
					<th width="30%">이름</th>
					<td width="70%">
						<input type="text" name="input_name" id="input_name" maxlength="255" value="<%=myName %>" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">나이</th>
					<td width="70%">
						<input type="number" min="1" max="150" name="input_age"
								id="input_age" value="<%=myAge %>" required="">					
					</td>
				</tr>
				<tr>
					<th width="30%">주소</th>
					<td width="70%">	
						<input type="text" name="input_address" id="input_address" maxlength="255" value="<%=myAddress %>" required="">					
					</td>
				</tr>
				<tr>
					<th width="30%">속성</th>
					<td width="70%">
						<%=myAttribute %>
					</td>
				</tr>
				<tr>
					<th width="30%">소지금</th>
					<td width="70%">
						<input type="number" name="input_customerbalance" id="input_customerbalance" value = "<%=myBalance%>">
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