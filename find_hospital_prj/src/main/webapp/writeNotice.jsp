<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<div id="board_section">
			<div class="box">
				<section id="main">
					<div id="title1">공지사항</div>
					<hr class="myhr">
					<div id="write2">
						<form action="writeNotice.do" method="post">
							<table>
								<tr>
									<td><input id="subj" type="text" placeholder="제목을 입력해주세요." name="subject"></td>
								</tr>
								<tr>
									<td><textarea id="cont" placeholder="내용을 입력하세요"
											name="contents"></textarea></td>
								</tr>
								<tr>
									<td style="text-align:right">
										<input type="submit" class="btn" value="확인">
										<input type="button" class="btn"
												onclick="location.href='noticeBoard.jsp'" value="취소">
										</td>
								</tr>
							</table>
						</form>
					</div>
				</section>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp" %>
<script>
$("input[type='submit']").click(function(){
	if($("#subj").val() == ''){
		alert("제목을 작성해주세요!!");
		$("#subj").focus();
		return false;
	}else if($("#cont").val() == ''){
		alert("내용을 작성해주세요!!");
		$("#cont").focus();
		return false;
	}else{
		alert("공지사항이 등록됩니다!!");
	}
});

</script>
</body>
</html>