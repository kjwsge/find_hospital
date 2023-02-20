function search_hosp(){
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
    	                
				        var map = new naver.maps.Map('map', {
				            center: new naver.maps.LatLng(lat, lng),
				            zoom: 17
				        });
				        
				        var marker = new naver.maps.Marker({
				            position: new naver.maps.LatLng(lat, lng),
				            map: map
				        });
				        
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