<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery.js"></script>
<script src=js/navjs.js></script>
</head>
<body>
	<nav>
	    <div id="slide_box">
	    </div>
	    <div class="box">
	        <ul id="main_menu">
	            <li id="main_logo"><a href="index.jsp"><img id="main_logo_img"
	                    src="./img/home_Icon2.png" alt="메인 로고"></a></li>
	            <li><a href="find_hospital.jsp">병원 찾기</a>
	                <ul>
	                    <li><a href="find_hospital.jsp">병원</a></li>
	                    <li><a href="find_t_g_hospital.jsp">대학병원</a></li>
	                    <li><a href="find_k_hospital.jsp">한방병원</a></li>
	                </ul>
	            </li>
	            <li><a href="find_clinic.jsp">의원 찾기</a>
	                <ul>
	                    <li><a href="find_clinic.jsp">의원</a></li>
	                    <li><a href="find_d_clinic.jsp">치과의원</a></li>
	                    <li><a href="find_k_clinic.jsp">한의원</a></li>
	                </ul>
	            </li>
	            <li><a href="find_pharmacy.jsp">약국 찾기</a>
	                <ul>
	                    <li><a href="find_pharmacy.jsp">약국</a></li>
	                </ul>
	            </li>
	            <li><a href="noticeBoard.jsp">공지사항</a>
	                <ul>
	                    <li><a href="noticeBoard.jsp">공지사항</a></li>
	                </ul>
	            </li>
	        </ul>    
	    </div>
	</nav>
</body>
</html>