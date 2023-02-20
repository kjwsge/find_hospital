package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {
	
	Connection conn = DBcon.getConnection();
	PreparedStatement pstmt;
	ResultSet rs;
	
	public int loginCheck(String id, String pw) {
		
		String query = "SELECT pw FROM member WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getString(1).equals(pw)) {
				return 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}
}
