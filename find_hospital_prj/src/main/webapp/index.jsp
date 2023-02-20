<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css">
<script src="js/jquery.js"></script>
</head>
<body>
	<div id="wrap">
        <%@ include file="header.jsp" %>
        <%@ include file="nav.jsp" %>
        <section>
            <div id="home_image"></div>
            <div class="box">
                <div id="main_txt"><p>의료<br>&nbsp;&nbsp;&nbsp;기관<br>&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;찾기<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포털</p></div>
                <div id="aside">
                	<h2 id="side_notice">공지사항</h2>
					<ul id="side_notice_list">

					</ul>
				</div>
            </div>
        </section>
    </div>
    <%@ include file="footer.jsp" %>
    <script>
	    $(document).ready(function(){
	
	    	$.ajax({
	    		url: "getList.do",
	    		type: "get",
	    		dataType: "text",
	    		success: function(data){ 
	
	    			let obj = JSON.parse(data);
	    			
	    			for (i = 0; i < 4; i++) {
	    				$("#side_notice_list").append('<li><p>' + obj[i].title 
	    						+ '</p><input type="hidden" value="'+ obj[i].nno + '"></li>');
	    				}
	    		},
	    		error: function(){
	    			alert("error.....");
	    		}
	    	});
	    });
	    
	    $("#side_notice_list").on('click', function(e){
	    	
	    	if(e.target.tagName == 'P'){
	    		location.href="viewNotice.jsp?nno="+e.target.parentElement.lastChild.value;
	    	}
	    });
	    
	    $("#side_notice").on('click', function(e){
	    	
	    	location.href="noticeBoard.jsp";
	    	
	    });
	    
    </script>
</body>
</html>