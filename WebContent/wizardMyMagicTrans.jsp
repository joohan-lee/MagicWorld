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
<title>wizardMyMagicTrans</title>
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
			<li><a href="wizardMaterialRegit.jsp">새로운 재료 등록</a></li>
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
			<li><a href="wizardMyMagicTrans.jsp"><strong>내 창조마법 거래내역</strong></a></li>
		</ul>
	</div>
	
	<div id="container">
		
	</div>

</body>
</html>