<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nukaceebzs"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=nukaceebzs&submodules=geocoder"></script>
<script src="js/jquery.js"></script>
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<div id="wrap">
        <%@ include file="header.jsp" %>
        <%@ include file="nav.jsp" %>
        <section>
            <div class="box">
                <div id="title1">병원 찾기</div>
                <hr>
				<br>
				<select>
					<option>전체 진료과</option>
					<option>가정의학과</option>
					<option>결핵과</option>
					<option>구강내과</option>
					<option>구강병리과</option>
					<option>구강악안면방사선과</option>
					<option>구강악안면외과</option>
					<option>구강안면외과</option>
					<option>내과</option>
					<option>마취통증의학과</option>
					<option>방사선종양학과</option>
					<option>병리과</option>
					<option>비뇨의학과</option>
					<option>산부인과</option>
					<option>산업의학과</option>
					<option>성형외과</option>
					<option>소아청소년과</option>
					<option>소아치과</option>
					<option>신경과</option>
					<option>신경외과</option>
					<option>안과</option>
					<option>영상의학과</option>
					<option>영상치의학과</option>
					<option>예방의학과</option>
					<option>예방치과</option>
					<option>외과</option>
					<option>응급의학과</option>
					<option>이비인후과</option>
					<option>작업환경의학과</option>
					<option>재활의학과</option>
					<option>정신건강의학과</option>
					<option>정형외과</option>
					<option>진단검사의학과</option>
					<option>치과</option>
					<option>치과교정과</option>
					<option>치과보존과</option>
					<option>치과보철과</option>
					<option>치료방사선과</option>
					<option>치주과</option>
					<option>통합치의학과</option>
					<option>피부과</option>
					<option>해부병리과</option>
					<option>핵의학과</option>
					<option>흉부외과</option>
				</select>
				<span>병원 검색 : </span><input id="search" placeholder="병원 이름을 입력 후 enter" size="20">
				<br>
				<div id="find">
                	<div id="map" style="width:800px;height:800px;"></div>
                	<div id="side"></div>
                	<div id="side2"><input class="btn" type="button" value="현 위치로"></div>
                </div>
            </div>
        </section>
    </div>
    <%@ include file="footer.jsp" %>
    <script>
    $(document).ready(my_location);
    $(document).ready(around_hosp);

    $("#search_dong").keyup(function(e) {
	    e.preventDefault();
	    if(e.keyCode == 13){
	    	search_dong();
    	}
	});

    $("#search").keyup(function(e){
    	if(e.keyCode == 13){
    		search_hosp();
    	}
    });
    
    $(".btn:eq(0)").click(function(){
    	my_location();
	});
    
    $("select").change(function(){
    	if($("select").val()== '전체 진료과'){
    		around_hosp();
    	}else{
    		search_exam_part();
    	}
    });

    var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(37.5666805, 126.9784147),
        zoom: 10,
        mapTypeId: naver.maps.MapTypeId.NORMAL
    });
    
    var markers = [];

    function my_location(){
    	if (navigator.geolocation) {
            /**
             * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
             * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
             * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
             */
		    var infowindow = new naver.maps.InfoWindow();
		
		    function onSuccessGeolocation(position) {
		        var location = new naver.maps.LatLng(position.coords.latitude,
		                                             position.coords.longitude);
		
		        map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
		        map.setZoom(17); // 지도의 줌 레벨을 변경합니다.
		
		        infowindow.setContent('<div style="padding:5px;">' + '현재 위치' + '</div>');
		
		        infowindow.open(map, location);
		        console.log('Coordinates: ' + location.toString());
		    }
		
		    function onErrorGeolocation() {
		        var center = map.getCenter();
		
		        infowindow.setContent('<div style="padding:20px;">' +
		            '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
		
		        infowindow.open(map, center);
		    }
            navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
        } else {
            var center = map.getCenter();
            infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
            infowindow.open(map, center);
        }
    }
    
    
    
	function search_hosp(){
		
		for (var i = 0; i < markers.length; i++) {
 			markers[i].setMap(null);
 			
 			}
		
	    var xhr = new XMLHttpRequest();
	    var url = 'http://apis.data.go.kr/6260000/MedicInstitService/MedicalInstitInfo'; /*URL*/
	    var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'CwHD%2FNPNXp9E%2B78PBTTmjae638MReKp54z9vm27vnitSWs%2BkBSltGWDi%2B0xq%2Bzveb%2Fo6zT6gNNHXPfBCBjhTdA%3D%3D'; /*Service Key*/
	    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
	    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('300'); /**/
	    queryParams += '&' + encodeURIComponent('resultType') + '=' + encodeURIComponent('json'); /**/
	    queryParams += '&' + encodeURIComponent('instit_kind') + '=' + encodeURIComponent('병원'); /**/

	    xhr.open('GET', url + queryParams);
	    xhr.onreadystatechange = function () {
	        if (this.readyState == 4) {
	        	let data = this.responseText;
                let hospital = JSON.parse(data);
                let obj = hospital.MedicalInstitInfo.body.items.item;
                
                $.each(obj, function(idx, value){

                	if(obj[idx].instit_nm.includes($("#search").val())){
                		
                		let lng = obj[idx].lng;
    	                let lat = obj[idx].lat;
				        
				        var marker = new naver.maps.Marker({
				            position: new naver.maps.LatLng(lat, lng),
				            map: map
				        });
				        
				        markers.push(marker);
				        
				        var contentString = [
				            '<div class="iw_inner">',
				            '   <h3>' + obj[idx].instit_nm + '</h3>',
				            '   <hr><p>주소 :' + obj[idx].street_nm_addr + '<br />',
				            '기관구분 : ' + obj[idx].medical_instit_kind + '>',
				            '  ' + obj[idx].instit_kind + '<br />',
				            '연락처 : ' + obj[idx].tel + '<br />',
				            '   </p>',
				            '</div>'
				        ].join('');

				    	var infowindow = new naver.maps.InfoWindow({
				    	    content: contentString,
				    	    maxWidth: 350,
				    	    backgroundColor: "#fff",
				    	    borderColor: "black",
				    	    borderWidth: 2,
				    	    anchorSize: new naver.maps.Size(5, 5),
				    	    anchorSkew: true,
				    	    anchorColor: "#eee",
				    	    pixelOffset: new naver.maps.Point(20, -20)
				    	});
						
				    	infowindow.open(map, marker);
		    	        $("#side").html("<h3> " + obj[idx].instit_nm + "</h3><hr><p><strong>주소</strong> : "
		    	        		+ obj[idx].street_nm_addr + "<br><strong>기관구분</strong> : " + obj[idx].medical_instit_kind + " > "
					            + obj[idx].instit_kind + "<br><strong>연락처</strong> : " + obj[idx].tel + "</p><hr>"
					            + "<table><tr><th>월요일 : </th><td>"+ obj[idx].Monday + "</td></tr>" 
					            + "<tr><th>화요일 : </th><td>"+ obj[idx].Tuesday + "</td></tr>"
					            + "<tr><th>수요일 : </th><td>"+ obj[idx].Wednesday + "</td></tr>"
					            + "<tr><th>목요일 : </th><td>"+ obj[idx].Thursday + "</td></tr>"
					            + "<tr><th>금요일 : </th><td>"+ obj[idx].Friday + "</td></tr>"
					            + "<tr><th>토요일 : </th><td>"+ obj[idx].Saturday + "</td></tr></table><hr>"
					            + "<p><strong>진료과목</strong> : " + obj[idx].exam_part + "</p>"
						);
				    	
				    	naver.maps.Event.addListener(marker, "click", function(e) {
				    	    if (infowindow.getMap()) {
				    	        infowindow.close();
				    	        $("#side").empty();
				    	    } else {
				    	        infowindow.open(map, marker);
				    	        $("#side").html("<h3> " + obj[idx].instit_nm + "</h3><hr><p><strong>주소</strong> : "
				    	        		+ obj[idx].street_nm_addr + "<br><strong>기관구분</strong> : " + obj[idx].medical_instit_kind + " > "
							            + obj[idx].instit_kind + "<br><strong>연락처</strong> : " + obj[idx].tel + "</p><hr>"
							            + "<table><tr><th>월요일 : </th><td>"+ obj[idx].Monday + "</td></tr>" 
							            + "<tr><th>화요일 : </th><td>"+ obj[idx].Tuesday + "</td></tr>"
							            + "<tr><th>수요일 : </th><td>"+ obj[idx].Wednesday + "</td></tr>"
							            + "<tr><th>목요일 : </th><td>"+ obj[idx].Thursday + "</td></tr>"
							            + "<tr><th>금요일 : </th><td>"+ obj[idx].Friday + "</td></tr>"
							            + "<tr><th>토요일 : </th><td>"+ obj[idx].Saturday + "</td></tr></table><hr>"
							            + "<p><strong>진료과목</strong> : " + obj[idx].exam_part + "</p>"
								);
				    	    }
				    	});

                	}
                });

            }
	        
	    };
	
	    xhr.send('');
	}
	
	function around_hosp(){
		
		var xhr = new XMLHttpRequest();
	    var url = 'http://apis.data.go.kr/6260000/MedicInstitService/MedicalInstitInfo'; /*URL*/
	    var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'CwHD%2FNPNXp9E%2B78PBTTmjae638MReKp54z9vm27vnitSWs%2BkBSltGWDi%2B0xq%2Bzveb%2Fo6zT6gNNHXPfBCBjhTdA%3D%3D'; /*Service Key*/
	    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
	    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('300'); /**/
	    queryParams += '&' + encodeURIComponent('resultType') + '=' + encodeURIComponent('json'); /**/
	    queryParams += '&' + encodeURIComponent('instit_kind') + '=' + encodeURIComponent('병원'); /**/

	    xhr.open('GET', url + queryParams);
	    xhr.onreadystatechange = function () {
	        if (this.readyState == 4) {
	        	
	        	let data = this.responseText;
                let hospital = JSON.parse(data);
                let obj = hospital.MedicalInstitInfo.body.items.item;

                $.each(obj, function(idx, value){

                	let lng = obj[idx].lng;
   	                let lat = obj[idx].lat;
					
			        var marker = new naver.maps.Marker({
			            position: new naver.maps.LatLng(lat, lng),
			            map: map
			        });
			        
			        markers.push(marker);

			        var contentString = [
			            '<div class="iw_inner">',
			            '   <h3>' + obj[idx].instit_nm + '</h3>',
			            '   <hr><p>주소 :' + obj[idx].street_nm_addr + '<br />',
			            '기관구분 : ' + obj[idx].medical_instit_kind + '>',
			            '  ' + obj[idx].instit_kind + '<br />',
			            '연락처 : ' + obj[idx].tel + '<br />',
			            '   </p>',
			            '</div>'
			        ].join('');

			    	var infowindow = new naver.maps.InfoWindow({
			    	    content: contentString,
			    	    maxWidth: 350,
			    	    backgroundColor: "#fff",
			    	    borderColor: "black",
			    	    borderWidth: 2,
			    	    anchorSize: new naver.maps.Size(5, 5),
			    	    anchorSkew: true,
			    	    anchorColor: "#eee",
			    	    pixelOffset: new naver.maps.Point(20, -20)
			    	});
   	
			    	naver.maps.Event.addListener(marker, "click", function(e) {
			    	    if (infowindow.getMap()) {
			    	        infowindow.close();
			    	        $("#side").empty();
			    	    } else {
			    	        infowindow.open(map, marker);
			    	        $("#side").html("<h3> " + obj[idx].instit_nm + "</h3><hr><p><strong>주소</strong> : "
			    	        		+ obj[idx].street_nm_addr + "<br><strong>기관구분</strong> : " + obj[idx].medical_instit_kind + " > "
						            + obj[idx].instit_kind + "<br><strong>연락처</strong> : " + obj[idx].tel + "</p><hr>"
						            + "<table><tr><th>월요일 : </th><td>"+ obj[idx].Monday + "</td></tr>" 
						            + "<tr><th>화요일 : </th><td>"+ obj[idx].Tuesday + "</td></tr>"
						            + "<tr><th>수요일 : </th><td>"+ obj[idx].Wednesday + "</td></tr>"
						            + "<tr><th>목요일 : </th><td>"+ obj[idx].Thursday + "</td></tr>"
						            + "<tr><th>금요일 : </th><td>"+ obj[idx].Friday + "</td></tr>"
						            + "<tr><th>토요일 : </th><td>"+ obj[idx].Saturday + "</td></tr></table><hr>"
						            + "<p><strong>진료과목</strong> : " + obj[idx].exam_part + "</p>"
							);
			    	    }
			    	});
			    	
                });
                
                
            }
	        
	    };
	
	    xhr.send('');
	}
	
	function search_exam_part(){

		for (var i = 0; i < markers.length; i++) {
 			markers[i].setMap(null);
 			
 			}
		
		var xhr = new XMLHttpRequest();
	    var url = 'http://apis.data.go.kr/6260000/MedicInstitService/MedicalInstitInfo'; /*URL*/
	    var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'CwHD%2FNPNXp9E%2B78PBTTmjae638MReKp54z9vm27vnitSWs%2BkBSltGWDi%2B0xq%2Bzveb%2Fo6zT6gNNHXPfBCBjhTdA%3D%3D'; /*Service Key*/
	    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
	    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('300'); /**/
	    queryParams += '&' + encodeURIComponent('resultType') + '=' + encodeURIComponent('json'); /**/
	    queryParams += '&' + encodeURIComponent('instit_kind') + '=' + encodeURIComponent('병원'); /**/

	    xhr.open('GET', url + queryParams);
	    xhr.onreadystatechange = function () {
	        if (this.readyState == 4) {
	        	
	        	let data = this.responseText;
                let hospital = JSON.parse(data);
                let obj = hospital.MedicalInstitInfo.body.items.item;
         		let val = $("select").val();

                $.each(obj, function(idx, value){

                	if(obj[idx].exam_part == val){
                	
	                	let lng = obj[idx].lng;
	   	                let lat = obj[idx].lat;
	   	                
				        var marker = new naver.maps.Marker({
				            position: new naver.maps.LatLng(lat, lng),
				            map: map
				        });
				        
				        markers.push(marker);
	
				        var contentString = [
				            '<div class="iw_inner">',
				            '   <h3>' + obj[idx].instit_nm + '</h3>',
				            '   <hr><p>주소 :' + obj[idx].street_nm_addr + '<br />',
				            '기관구분 : ' + obj[idx].medical_instit_kind + '>',
				            '  ' + obj[idx].instit_kind + '<br />',
				            '연락처 : ' + obj[idx].tel + '<br />',
				            '   </p>',
				            '</div>'
				        ].join('');
	
				    	var infowindow = new naver.maps.InfoWindow({
				    	    content: contentString,
				    	    maxWidth: 350,
				    	    backgroundColor: "#fff",
				    	    borderColor: "black",
				    	    borderWidth: 2,
				    	    anchorSize: new naver.maps.Size(5, 5),
				    	    anchorSkew: true,
				    	    anchorColor: "#eee",
				    	    pixelOffset: new naver.maps.Point(20, -20)
				    	});
	   	
				    	naver.maps.Event.addListener(marker, "click", function(e) {
				    	    if (infowindow.getMap()) {
				    	        infowindow.close();
				    	        $("#side").empty();
				    	    } else {
				    	        infowindow.open(map, marker);
				    	        $("#side").html("<h3> " + obj[idx].instit_nm + "</h3><hr><p><strong>주소</strong> : "
				    	        		+ obj[idx].street_nm_addr + "<br><strong>기관구분</strong> : " + obj[idx].medical_instit_kind + " > "
							            + obj[idx].instit_kind + "<br><strong>연락처</strong> : " + obj[idx].tel + "</p><hr>"
							            + "<table><tr><th>월요일 : </th><td>"+ obj[idx].Monday + "</td></tr>" 
							            + "<tr><th>화요일 : </th><td>"+ obj[idx].Tuesday + "</td></tr>"
							            + "<tr><th>수요일 : </th><td>"+ obj[idx].Wednesday + "</td></tr>"
							            + "<tr><th>목요일 : </th><td>"+ obj[idx].Thursday + "</td></tr>"
							            + "<tr><th>금요일 : </th><td>"+ obj[idx].Friday + "</td></tr>"
							            + "<tr><th>토요일 : </th><td>"+ obj[idx].Saturday + "</td></tr></table><hr>"
							            + "<p><strong>진료과목</strong> : " + obj[idx].exam_part + "</p>"
								);
				    	    }
				    	});
			    	
                	}
                });
                
                
            }
	        
	    };
	
	    xhr.send('');
	}
	
	
	function search_dong(){
		naver.maps.Service.geocode({
	        query: $("#search_dong").val()
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }
			
        var result = response.v2, // 검색 결과의 컨테이너
            items = result.addresses; // 검색 결과의 배열
            
        alert('여기');
        var x = items.x,
        	y = items.y;
        
        var dong = new naver.maps.LatLng(x, y);
	    map.panTo(dong);
	            
	        // do Something
	    });
	}
	

	

    </script>
</body>
</html>