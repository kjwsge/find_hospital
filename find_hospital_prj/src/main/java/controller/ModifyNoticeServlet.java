package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.BoardDAO;
import vo.NoticeVO;

@WebServlet("/modifyNotice.do")
public class ModifyNoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String _nno = request.getParameter("nno");
		int nno = Integer.parseInt(_nno);
		String subject = request.getParameter("subject");
		String contents = request.getParameter("contents");

		NoticeVO notice = new NoticeVO();
		
		notice.setNno(nno);
		notice.setTitle(subject);
		notice.setContent(contents);

		BoardDAO dao = new BoardDAO();
		
		dao.updateNotice(notice);
		
		response.sendRedirect("noticeBoard.jsp");
	}

}
