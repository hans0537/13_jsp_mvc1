package step3_00_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class BoardDAO {

	private BoardDAO() {}
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 반환 타입은 Connection 객체이며 메소드 명은 관용적으로 getConnection으로 작명한다.
	public Connection getConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			String jdbcUrl = "jdbc:mysql://localhost:3306/STEP3_BOARD_EX?serverTimezone=UTC";
			String dbId    = "root";
			String dbPass  = "1234";

			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public void insertBoard(BoardDTO boardDTO) {
			   
		try {
			conn = getConnection();
			
			String sql = "INSERT INTO BOARD(WRITER,EMAIL,SUBJECT,PASSWORD,REG_DATE,READ_COUNT,CONTENT)";
			sql += "VALUES(?,?,?,?,NOW(),0,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getWriter());
			pstmt.setString(2, boardDTO.getEmail());
			pstmt.setString(3, boardDTO.getSubject());
			pstmt.setString(4, boardDTO.getPassword());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt!=null)  try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null) try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
	}
	
	// 전체 게시글을 조회하는 DAO
	public ArrayList<BoardDTO> getAllBoard() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		BoardDTO bdto = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("SELECT * FROM BOARD");
			rs = pstmt.executeQuery();

			while(rs.next()) {
				
				bdto = new BoardDTO();
				bdto.setNum(rs.getInt(1));					// bdto.setNum(rs.getInt("num"));
				bdto.setWriter(rs.getString(2));			// bdto.setWriter(rs.getString("writer");
				bdto.setEmail(rs.getString(3));				// bdto.setEmail(rs.getString("email"));
				bdto.setSubject(rs.getString(4));			// bdto.setSubject(rs.getString("subject"));
				bdto.setPassword(rs.getString(5));			// bdto.setPassword(rs.getString("password"));
				bdto.setRegDate(sdf.format(rs.getDate(6))); // bdto.setRegDate(sdf.format(rs.getDate("reg_date"))); date형식은 문자열로 해야하기 때문에 sdf.format사용
				bdto.setReadCount(rs.getInt(7));			// bdto.setReadCount(rs.getInt("read_count"));
				bdto.setContent(rs.getString(8));			// bdto.setContent(rs.getString("content"));
				
				boardList.add(bdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null)  try {rs.close();} catch (Exception e) {e.printStackTrace();}
			if (pstmt!=null)  try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if (conn != null) try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
		return boardList;
	}
}