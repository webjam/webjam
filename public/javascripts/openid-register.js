/*
	Adds a fieldset to help people enter common OpenID services they may not know about.
*/
(function() {
	var addEvent = function() {
	  if (window.addEventListener) {
	    return function(el, type, fn) {
	      el.addEventListener(type, fn, false);
	    };
	  } else if (window.attachEvent) {
	    return function(el, type, fn) {
	      var f = function() {
	        fn.call(el, window.event);
	      };
	      el.attachEvent('on' + type, f);
	    };
	  }
	}();

	var openIdProviders = {
		"Wordpress blog": "http://<username>.wordpress.com/",
		"Technorati username": "http://technorati.com/people/<username>/",
		"AIM username": "http://openid.aol.com/<username>",
		"Live Journal username": "http://<username>.livejournal.com/"
	}

	var	explanationParagraph = function() {
		var p = document.createElement("p");
		p.innerHTML = 'Alternatively, pick one of your logins so we may construct your <a href="http://openid.net/">OpenID</a> for you.'
		return p;
	}
			
	/*
		Appends a fieldset to the input's form with some helpers for constructing OpenID URLs for common
    services.

		The fieldset that's generated looks like:
			<fieldset class="contruct-openid">
				<select>
					<option>Wordpress</option>
					<option>...</option>
				</select>
				<p>http://<input type="text" value="" />.wordpress.com</p>
			</fieldset>
	*/
	var initOpenIDHelper = function(urlInput) {
		var form = urlInput;
		while (form.tagName != "FORM") {
			form = form.parentNode;
		}
		
		var fieldset = document.createElement("fieldset");
		fieldset.className = "contruct-openid";

		fieldset.appendChild(explanationParagraph());
		
		var service = document.createElement("select");
		for (var serviceName in openIdProviders) {
			var option = document.createElement("option");
			option.value = serviceName;
			option.appendChild(document.createTextNode(serviceName));
			service.appendChild(option);
		}
		fieldset.appendChild(service);
		
		form.appendChild(fieldset);
		
		var showUsernameInput = function() {
			var username = document.createElement("input");
			username.type = "text";
			form.appendChild(username);
			
			addEvent(username, "keyup", function() {
				var urlTemplate = openIdProviders[service.value];
				urlInput.value = urlInput.value ? urlTemplate.replace("<username>", username.value) : urlTemplate;
				return true;
			});
			
			return true;
		}
		
		addEvent(fieldset, "change", showUsernameInput);
	}
	
	// An input field is an OpenID URL if it has the id or a class name "openid_url"
	var isOpenIdUrlInput = function(input) {
		return input.id == "openid_url" ||
					   input.className && input.className.match(/(^| )openid_url( |$)/)
	}
		
	addEvent(window, 'load', function() {
		var inputs = document.getElementsByTagName("input");
		for (var i = 0; i<inputs.length; i=i+1) {
			if (isOpenIdUrlInput(inputs[i])) initOpenIDHelper(inputs[i]);
		}
	})
})();