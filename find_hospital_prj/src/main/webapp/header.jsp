<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<div class="box">
	    <div id="header_logo">
	        <a href="index.jsp">
	            <img id="header_logo_img" src="./img/Home_Icon.svg" alt="헤더 로고">
	        </a>
	    </div>
	    <div id="header_login">
	        <ul id="header_menu">
	        	<c:if test="${sessionScope.id != null }">
	                <li><a href="logout.do">로그아웃</a></li><li>|</li>
	                <li>${sessionScope.id }님 환영합니다.</li>
	        	</c:if>
	        	<c:if test="${sessionScope.id == null }">
	                <li><a href="login.do">로그인</a></li>
	        	</c:if>
	        </ul>
	    </div>
	    </div> 
	</header>
</body>
</html>