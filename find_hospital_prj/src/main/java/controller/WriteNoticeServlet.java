package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.BoardDAO;
import vo.NoticeVO;

@WebServlet("/writeNotice.do")
public class WriteNoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("writeNotice.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String subject = request.getParameter("subject");
		String contents = request.getParameter("contents");
		
		NoticeVO board = new NoticeVO();
		board.setTitle(subject);
		board.setContent(contents);
		BoardDAO dao = new BoardDAO();
		dao.insertNotice(board);
		response.sendRedirect("noticeBoard.jsp");
	}

}
