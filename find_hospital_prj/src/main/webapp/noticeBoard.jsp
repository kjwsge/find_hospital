<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<section>
				<div id="title1">공지사항</div>
				<hr>
				<table id="board">
					<thead>
						<tr>
							<th>글 번호</th>
							<th style="width: 50%">글 제목</th>
							<th>작성자</th>
							<th style="width: 15%">작성일자</th>
						</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
				<input id="write" type="button" value="글쓰기">
			</section>
		</div>
	</div>
	<%@ include file="footer.jsp" %>   
<script>
$("#write").click(function(){
	if(${sessionScope.id != 'admin'}){
		alert('관리자로 로그인해주세요!');
	}else {
		location.href='writeNotice.do';	
	}
});

$(document).ready(function(){

	$.ajax({
		url: "getList.do",
		type: "get",
		dataType: "text",
		success: function(data){ 

			let obj = JSON.parse(data);
			
			for (i = 0; i < 10; i++) {
				$("tbody").append('<tr><td>' + obj[i].nno + '</td><td>'
					+ obj[i].title + '</td><td>관리자</td><td>'
						+ obj[i].w_date + '</td></tr>');
				}
			$("tbody").append('<tr><td id="page" colspan="4"></td></tr>');
			if(obj.length > 10){
				for(let j = 1; j < obj.length/10+1; j++ ){
					$("#page").append("<span>"+ j +"</span>");
					
				}
			}
		},
		error: function(){
			alert("error.....");
		}
	});
});

$("tbody").on('click', function(e){
	if(e.target.tagName == 'SPAN'){
		$("tbody").empty();
		$.ajax({
			url: "getList.do",
			type: "get",
			dataType: "text",
			success: function(data){ 
				
				let obj = JSON.parse(data);
				let i = (e.target.innerText)*10-10;
				
				for (i; i < e.target.innerText*10; i++) {
					if(i == obj.length){
						break;
					}
					$("tbody").append('<tr><td>' + obj[i].nno + '</td><td>'
						+ obj[i].title + '</td><td>관리자</td><td>'
							+ obj[i].w_date + '</td></tr>');
					}
				$("tbody").append('<tr><td id="page" colspan="4"></td></tr>');
				if(obj.length > 10){
					for(let j = 1; j < obj.length/10+1; j++ ){
						$("#page").append("<span>"+ j +"</span>");
						
					}
				}
			},
			error: function(){
				alert("error.....");
			}
		});
	}
});

$("tbody").on('click', function(e){
	if(e.target.tagName == 'TD' && e.target.id != 'page'){
		location.href="viewNotice.jsp?nno="+e.target.parentElement.firstChild.innerText;
	}
});

</script>
</body>
</html>