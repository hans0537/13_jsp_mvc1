<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
	<h2>회원정보 수정</h2>
	<form action="06_updatePro.jsp" method="post">
		아이디 : <input type="text" id="id" name="id"> <br>
		비밀번호 : <input type="password" id=passwd name="passwd"><br>
		이름 : <input type="text" id="name"  name="name"><br>
		<input type="submit" value="회원가입">
	
	</form>
</body>
</html>