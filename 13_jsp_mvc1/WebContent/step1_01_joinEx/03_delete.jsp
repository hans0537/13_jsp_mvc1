<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>

	<h2>회원 탈퇴</h2>
	<form action="04_deletePro.jsp" method="post">
		
		<p>아이디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="password" name="passwd"></p>
		<input type="submit" value="회원탈퇴">
	
	
	</form>
</body>
</html>