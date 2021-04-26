<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 리스트</title>
</head>
<body>

	<%
	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		
		request.setCharacterEncoding("utf-8");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String rId = "";
		String rPasswd = "";
		String rName = "";
		String rDate = "";

		try {

			Class.forName("com.mysql.jdbc.Driver");

			String jdbcUrl = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String dbId = "root";
			String dbPass = "1234";

			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

			pstmt = conn.prepareStatement("select * from member");
			rs = pstmt.executeQuery();
		%>
	<h2>회원 리스트</h2>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>PASSWORD</th>
			<th>NAME</th>
			<th>JOIN DATE</th>
		</tr>
		<% 
				while(rs.next()){
					
					/*
						db의 컬럼명을 가져오는 2가지 방법
						
						1) rs.get 자료형메서드 ("컬럼명");
						    ex) rs.getInt("num"), rs.getInt("age")
						2) rs.get자료형메서드(index);
							ex) rs.getInt(1), rs.getInt(2)
						3) 
						- 유지보수 및 가독성 향상을 위해서 컬럼명지정 방식을 권장한다.
						- index가 1부터 시작되는 점을 유의해야 한다.
					*/
					
					rId = rs.getString("id");						 //rs.getString(1);
					rPasswd = rs.getString("passwd");				 //rs.getString(2);
					rName = rs.getString("name");					 //rs.getString(3);
					rDate = sdf.format(rs.getTimestamp("joindate")); //rs.getTimestamp(4);
		%>
				<tr align="center">
					<td><%=rId %></td>
					<td><%=rPasswd %></td>
					<td><%=rName %></td>
					<td><%=rDate %></td>				
				</tr>
		
		<%
				}
		%>
		
			</table>
		
		<% 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if (pstmt != null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null) try {conn.close();} catch (Exception e) {	e.printStackTrace();}
		}
	%>
	
</body>
</html>