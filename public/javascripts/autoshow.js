jQuery.fn.autoshow = function(options) {
	var settings = {
		timeout: '3000',
		type: 'random',
		pause_selector: '.slideshow li img',
	}

	var current = 1;
	var counter = 0;
	var last = 0;
	var timer = '';
	var pause_state = 0;
	
	var slides = this.find('li').get();

	jQuery(slides[0]).show();

	var showSlide = function (hero) {
		$(hero).fadeIn('fast');
	}
	
	var hideSlide = function (hero) {
		$(hero).fadeOut('fast');
	}

	var change = function () {
		if (pause_state != 1) {
			for (var i = 0; i < slides.length; i++) {
				jQuery(slides[i]).css('display', 'none');
			}
			counter = counter + 1;
			hideSlide(jQuery(slides[last]));
			showSlide(jQuery(slides[current]));

			if ( settings.type == 'sequence' ) {
				if ( ( current + 1 ) < slides.length ) {
					current = current + 1;
					last = current - 1;
				}
				else {
					current = 0;
					last = slides.length - 1;
				}
			}
			else if ( settings.type == 'random' ) {
				last = current;
				while (	current == last ) {
					current = Math.floor ( Math.random ( ) * ( slides.length ) );
				}
			}
			else {
				alert('type must either be \'sequence\' or \'random\'');
			}
			timer = setTimeout(change, settings.timeout);
		}
	}

	var pause = function() {
		console.log('pause');
		pause_state = 1;
		clearTimeout(timer);
	}

	var resume = function() {
		console.log('resume');
		pause_state = 0;
		change();
	}
	
	if ( settings.type == 'sequence' ) {
		timer = setTimeout(change, settings.timeout);
	}
	else if ( settings.type == 'random' ) {
		do { current = Math.floor ( Math.random ( ) * ( slides.length ) ); } while ( current == 0 )
		timer = setTimeout(change, settings.timeout);
	}
	else {
		alert('type must either be \'sequence\' or \'random\'');
	}
	
	if ( settings.pause_selector != null ) {
		jQuery(settings.pause_selector).hover(pause, resume);
	}


	return this;
};