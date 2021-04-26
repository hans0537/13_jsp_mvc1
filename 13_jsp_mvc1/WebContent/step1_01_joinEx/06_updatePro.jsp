<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		Connection conn 		= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");

			String jdbcUrl = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String dbId    = "root";
			String dbPass  = "1234";
			
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			pstmt = conn.prepareStatement("select id,passwd from member where id=? and passwd=?");
			pstmt.setString(1,request.getParameter("id"));
			pstmt.setString(2,request.getParameter("passwd"));
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pstmt = conn.prepareStatement("update member set name=? where id=?");	
				pstmt.setString(1, request.getParameter("name"));
				pstmt.setString(2, request.getParameter("id"));
				pstmt.executeUpdate();
	%>
				<script>
					alert("수정 되었습니다.");
					location.href = "00_main.jsp";
				</script>
	<% 
			}
			else {
	%>
				<script>
					alert("아이디와 비밀번호를 확인하세요.");
					history.go(-1);
				</script>
	<% 			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)    try {rs.close();}    catch (Exception e) {e.printStackTrace();}
			if (pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null)  try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
		
	%>
	
</body>
</html>