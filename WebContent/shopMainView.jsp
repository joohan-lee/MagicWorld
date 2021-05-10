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
<title>shopMainView</title>
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
					<li><a href="shopMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="shopTrans.jsp">내 창조마법 거래내역</a></li>
		</ul>
	</div>
	
	<div id="container">
		
	</div>

</body>
</html>