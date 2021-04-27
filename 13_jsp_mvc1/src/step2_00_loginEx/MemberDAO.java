package step2_00_loginEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// DAO(Data Access Object) : 데이터 접근 객체
public class MemberDAO {

	// 싱글턴 패턴
	private MemberDAO() {}
	private static MemberDAO instance = new MemberDAO();
	public MemberDAO getInstance() {
		return instance;
	}
	
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 반환 타입은 Connection 객체이며 메소드 명은 관용적으로 getConnection으로 작명한다.
	public Connection getConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			String jdbcUrl = "jdbc:mysql://localhost:3306/login_ex?serverTimezone=UTC";
			String dbId    = "root";
			String dbPass  = "1234";

			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}


}
