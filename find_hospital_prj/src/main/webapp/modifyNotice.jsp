<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="css/notice.css">
</head>
<body>
	<div id="wrap">
	<%@ include file="header.jsp" %>
	<%@ include file="nav.jsp" %>
		<div class="box">
			<section id="main">
				<div id="title1">공지사항</div>
				<hr>
				<div id="write2">
					<form action="modifyNotice.do" method="post">
						<table>
							<sql:query var="rs" dataSource="jdbc/maria">SELECT * FROM notice WHERE nno = ${param.nno };</sql:query>
							<c:forEach var="row" items="${rs.rows }">
								<tr>
									<td><input id="subj" type="text" name="subject"
										value="${row.title }"></td>
								</tr>
								<tr>
									<td><textarea id="cont" name="contents">${row.content }</textarea></td>
								</tr>
								<tr>
									<td style="text-align:right">
										<button type="submit" class="btn">수정</button>
										<button type="button" class="btn" onclick="location.href='noticeBoard.jsp'">뒤로</button> 
										<input type="hidden" name="nno" value="${param.nno }">
									</td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
			</section>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
</body>
</html>