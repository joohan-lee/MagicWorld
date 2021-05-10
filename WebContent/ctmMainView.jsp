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
<title>ctmMainView</title>
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
					<li><a href="ctmMyInfoModify.jsp">수정</a></li>
				</ul>
			<li><a href="ctmMyTrans.jsp">내 거래내역</a></li>
			<li><a href="ctmMyMagicView.jsp">구매한 마법</a></li>			
		</ul>
	</div>
	
	<div id="container">
		
	</div>

</body>
</html>