$(document).ready(function() {
	var lnb = $('#main_menu');

	lnb.mouseenter(function() {
        $('#main_menu > li > ul').stop();
        $("#slide_box").finish();
        $("#slide_box").show();
		$('#main_menu > li > ul').slideDown("500");
		$('#main_menu > li > ul').css("display", "flex");
		
	});

	lnb.mouseleave(function() {
        $('#main_menu > li > ul').stop();
        $("#slide_box").slideUp("slow");
        $('#main_menu > li > ul').slideUp("fast");
        
	});
});