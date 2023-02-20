<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="css/notice.css">
</head>
<body>
<div id="box">
	<h1>공지사항</h1>
	<hr>
	<table border="1">
		<thead>
			<tr>
				<th>글 번호</th>
				<th style="width: 50%">글 제목</th>
				<th>작성자</th>
				<th style="width: 10%">작성일자</th>
			</tr>
		</thead>
		<tbody id="tbody">
			
		</tbody>
	</table>
</div>
<script>

$(document).ready(function(){

	$.ajax({
		url: "getList.do",
		type: "get",
		dataType: "text", //서버로부터 받을 테이터의 타입
		success: function(data){ 

			let obj = JSON.parse(data);
			
			for (i = 0; i < 10; i++) {
				if(i == obj.length){
					break;
				}
				$("tbody").append('<tr><td>' + obj[i].nno + '</td><td>'
					+ obj[i].title + '</td><td>관리자</td><td>'
						+ obj[i].w_date + '</td></tr>');
				}
			$("tbody").append('<tr><td id="page"></td></tr>');
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
		alert('클릭');
		$("tbody").empty();
		$.ajax({
			url: "getList.do",
			type: "get",
			dataType: "text", //서버로부터 받을 테이터의 타입
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
				$("tbody").append('<tr><td id="page"></td></tr>');
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

</script>
</body>
</html>