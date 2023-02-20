<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/notice.css">
</head>
<body>
	<div id="wrap">
		<%@ include file="header.jsp"%>
		<%@ include file="nav.jsp"%>
		<div class="box">
			<section id="main">
				<div id="title1">공지사항</div>
				<hr>
				<div id="write2">
					<table>
					<sql:query var="rs" dataSource="jdbc/maria">SELECT * FROM notice WHERE nno = ${param.nno };</sql:query>
					<c:forEach var="row" items="${rs.rows }">
						<tr>
							<td><input id="subj" type="text" name="subject"
								value="${row.title }" readonly></td>
						</tr>
						<tr>
							<td><textarea id="cont" name="contents" readonly>${row.content }</textarea></td>
						</tr>
						<tr>
							<td>작성일자 : <input value="${row.w_date }" readonly>
							</td>
						</tr>
						<tr>
							<td style="text-align:right">
								<c:if test="${sessionScope.id == 'admin' }">
								<button type="button" class="btn"
									onclick="location.href='modifyNotice.jsp?nno=${param.nno }'">수정</button>
								<button type="button" class="btn">삭제</button>
								</c:if>
								<button type="button" class="btn"
									onclick="location.href='noticeBoard.jsp'">목록</button>	
							</td>
						</tr>
					</c:forEach>
					</table>
				</div>
			</section>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	<script>
		$(".btn:eq(1)").click(function(){
			if(confirm('삭제하시겠습니까?')){
				alert('삭제됩니다!');
				location.href='deleteNotice.do?nno=${param.nno }';
			}else{
				alert('삭제취소!!');
				return false;
			}
		});
	</script>
</body>
</html>