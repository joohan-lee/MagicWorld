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
	<div id="header">
		<%=userId %>님, 환영합니다.
		<input type="button" value="logout" onclick="location.href='Logout.jsp';">
	</div>
	
	<div id="nav">
		<ul>
			<li><a href="wizardMaterialRegit.jsp"><strong>새로운 재료 등록</strong></a></li>
			<li><a href="wizardMagicRegit.jsp">새로운 마법 등록</a></li>
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
		<form method="get" action="wizardMaterialRegitOK.jsp" name="materialInput">
			<table>
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
					<th width="30%">원산지</th>
					<td width="70%">
						<input type="text" name="input_origin" id="input_origin" maxlength="255" required="">
					</td>
				</tr>
				<tr>
					<th width="30%">종류(Type)</th>
					<td width="70%">
							<select name="input_typeSelect" id = "input_typeSelect">
								<option>vegetable</option>
								<option>animal</option>
								<option>mineral</option>
							</select>
					</td>
				</tr>
				<tr>
					<th width="30%">가격</th>
					<td width="70%">
							<input type="number" name="input_price" id="input_price" required="">
					</td>
				</tr>
			</table>
			<input type="submit" value="등록">
		</form>
	</div>

</body>
</html>