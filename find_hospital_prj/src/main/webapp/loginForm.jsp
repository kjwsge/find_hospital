<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% if(session.getAttribute("id")!=null){
		response.sendRedirect("index.jsp");		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery.js"></script>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div id="login">
        <img src="img/home_Icon2.png">
        <form name="frm">
            <table>
                <tr>
                    <td><input type="text" placeholder="    아이디" name="id"></td>
                </tr>
                <tr>
                    <td><input type="password" placeholder="    비밀번호" name="pw"></td>
                </tr>
                <tr><td><input type="submit" value="로그인"></td></tr>
            </table>
        </form>
    </div>
    <script>
    	$("input[type='submit']").click(function(e){
    		e.preventDefault();
    		const formData = $(frm).serialize();
    		$.ajax({
    			url: "login.do",
    			type: "post",
    			data: formData,
    			dataType: "text",
    			success: function(data){
    				if(data == 1){
    					alert("로그인 성공!!");
    					location.href='index.jsp';
    				}else{
    					alert("로그인 실패!!");
    				}
    			}
    		});
    	});
    </script>
</body>
</html>