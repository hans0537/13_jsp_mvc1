<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>09_logout</title>
</head>
<body>

	<%
		session.invalidate(); // 세션값을 모두 삭제
		// response.sendRedirect("00_main.jsp");
	%>
	
	<script>
		alert("you are logged out.");
		location.href = "00_main.jsp";
	</script>


</body>
</html>