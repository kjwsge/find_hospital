	$("#search_dong").keyup(function(e) {
	    e.preventDefault();
	    if(e.keyCode == 13){
	    	search_dong();
    	}
	});
	
    $("select").change(function(){
    	var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(lat, lng),
            zoom: 17
        });
    	around_hosp();
    });