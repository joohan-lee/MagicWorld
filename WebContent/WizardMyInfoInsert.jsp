<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마법사 정보 입력</h1>
	<form action="WizardMyInfoInsertOK.jsp" method="post">
	<table>
		<tr>
			<th>WizardID</th>
			<td><input type="text" name="WizardID"></td>
		</tr>
		<tr>
			<th>Password</th>
			<td><input type="password" name="Password"></td>
		</tr>
		<tr>
			<th>Name</th>
			<td><input type="text" name="Name"></td>
		</tr>
		<tr>
			<th>Age</th>
			<td><input type="text" name="Age"></td>
		</tr>
		<tr>
			<th>Tribe</th>
			<td><input type="text" name="Tribe"></td>
		</tr>
		<tr>
			<th>Hometown</th>
			<td><input type="text" name="Hometown"></td>
		</tr>
		<tr>
			<th>Occupation</th>
			<td><input type="text" name="Occupation"></td>
		</tr>
		<tr>
			<th>Class</th>
			<td><input type="text" name="Class"></td>
		</tr>
		<tr>
			<th>Attribute</th>
			<td><input type="text" name="Attribute"></td>
		</tr>
		<tr>
			<th>Mana</th>
			<td><input type="text" name="Mana"></td>
		</tr>
		<tr>
			<th>Balance</th>
			<td><input type="text" name="Balance"></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="등록"></td>
		</tr>
	</table>
	</form>
</body>
</html>