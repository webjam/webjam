/*------------------------------------------------------------
*  
*  Function:     startup
*  
*  Description:  Executes functions when ready.
*
*------------------------------------------------------------*/

function startup() {

	var num_slides = $('.slideshow li').length;
	if ( num_slides > 1) {
		$('.slideshow li').hide();
		$('.slideshow').autoshow();

		$("h2").click( function() {alert("fuck yeah!")});
		}
	}
	
$(document).ready(startup);