package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

import vo.NoticeVO;

public class BoardDAO {

	Connection conn = DBcon.getConnection();
	PreparedStatement pstmt;
	ResultSet rs;

	public JSONArray getList() {
		
		JSONArray list = new JSONArray();
		String query = "SELECT * FROM notice ORDER BY nno DESC";
		
		try {
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				
				obj.put("nno", rs.getString(1));
				obj.put("title", rs.getString(2));
				obj.put("w_date", rs.getString(4));
				
				list.put(obj);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	public void insertNotice(NoticeVO board) {
		String query = "INSERT INTO notice (title, content, w_date) VALUES (?, ?, NOW())";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void updateNotice(NoticeVO board) {
		String query = "UPDATE notice SET title = ?, content = ? WHERE nno = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNno());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteNotice(int nno) {
		String query = "DELETE FROM notice WHERE nno = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, nno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	
}
