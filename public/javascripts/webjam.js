/*------------------------------------------------------------
*  
*  Function:     startup
*  
*  Description:  Executes functions when ready.
*
*------------------------------------------------------------*/

function startup() {

  // Setting up slideshow
	var num_slides = $('.slideshow li').length;
	if ( num_slides > 1) {
		$('.slideshow li').hide();
		$('.slideshow').autoshow();
	}

  // Setting up video player
	$.fn.media.defaults.bgColor = '#0d0e0e';
	$.fn.media.defaults.caption = false;
  $.fn.media.defaults.width = '437px';
	$.fn.media.defaults.params = {allowFullScreen : true};
	$('a.show-media').media();
	
}
	
$(document).ready(startup);