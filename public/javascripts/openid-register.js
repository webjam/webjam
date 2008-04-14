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
		"Wordpress": "http://<username>.wordpress.com",
		"Blogger": "http://<username>.blogger.com",
		"Flickr": "http://www.flickr.com/photos/<username>",
		"Technorati": "http://technorati.com/people/<username>",
		"AOL": "http://openid.aol.com/<username>",
		"Live Journal": "http://<username>.livejournal.com"
	}

	var	explanationParagraph = function() {
		var p = document.createElement("p");
		
		var providerNames = [];
		for (providerName in openIdProviders) {
			providerNames.push(providerName);
		}
		
		var providersInSentenceForm = "";
		for (var i=0; i < providerNames.length; i=i+1) {
			if (i == 0) {
				providersInSentenceForm = providersInSentenceForm + providerNames[i];
			} else if (i == (providerNames.length - 1)) {
				providersInSentenceForm = providersInSentenceForm + " or " + providerNames[i];
			} else {
				providersInSentenceForm = providersInSentenceForm + ", " + providerNames[i];
			}
		}
		
		p.innerHTML = 'If you use ' + providersInSentenceForm + ' you probably already have an OpenID and you didn&rsquo;t even know it. If you want to register your own see <a href="http://openid.net/get/">openid.net</a> for a list of reputable OpenID providers.'
		p.className = "explanation";
		return p;
	}
			
	/*
		Replaces the OpenID URL input with some helpers for constructing OpenID
    URLs for common services.

		The input is replaced with something like:
			<span class="contruct-openid">
				<input class="hidden" type="hidden" value="http://ablog.wordpress.com" />
				<select>
					<option>Wordpress</option>
					<option>...</option>
				</select>
				<input class="text" type="text" value="ablog" />
				<em class="preview">http://ablog.wordpress.com</em>
			</span>
			
		A pragraph is also placed as the first child of the containing form:
			<p class="explanation">If you use WordPress...</p>
	*/
	var initOpenIDHelper = function(urlInput) {
		var form = urlInput;
		while (form.tagName != "FORM") {
			form = form.parentNode;
		}

		form.insertBefore(explanationParagraph(), form.firstChild);
		
		var surroundingSpan = document.createElement("span");
		surroundingSpan.className = "construct-openid";
		
		var hiddenUrlInput = document.createElement("input");
		hiddenUrlInput.type = "hidden";
		hiddenUrlInput.className = "hidden";
		hiddenUrlInput.name = urlInput.name;
		hiddenUrlInput.value = urlInput.value;
		surroundingSpan.appendChild(hiddenUrlInput);
		
		var service = document.createElement("select");
		surroundingSpan.appendChild(service);
		
		var option = document.createElement("option");
		option.value = "";
		option.appendChild(document.createTextNode("OpenID URL"));
		service.appendChild(option);
		
		var optGroup = document.createElement("optgroup");
		optGroup.label = "OpenID Enabled Services";
		
		for (var serviceName in openIdProviders) {
			var option = document.createElement("option");
			option.value = serviceName;
			option.appendChild(document.createTextNode(serviceName));
			optGroup.appendChild(option);
		}
		
		service.appendChild(optGroup);
		
		var newInput = document.createElement("input");
		newInput.type = "text";
		newInput.className = "text";
		newInput.value = "";
		surroundingSpan.appendChild(newInput);

		var previewEm = document.createElement("em");
		previewEm.style.className = "preview";
		previewEm.style.display = "none";
		surroundingSpan.appendChild(previewEm);

		var updateUrl = function() {
			if (service.value == "") {
				hiddenUrlInput.value = newInput.value;
			} else {
				var urlTemplate = openIdProviders[service.value];
				if (newInput.value == "") {
					var replaceUsername = "(username)";
				} else {
					var replaceUsername = newInput.value;
				}
				hiddenUrlInput.value = urlTemplate.replace("<username>", replaceUsername);
				previewEm.innerHTML = hiddenUrlInput.value;
			}
		}
		
		addEvent(newInput, "keyup", updateUrl);
		
		addEvent(service, "change", function() {
			if (service.value == "") {
				previewEm.style.display = "none";
			} else {
				previewEm.style.display = "block";
			}
			
			updateUrl();
		});
		
		urlInput.parentNode.replaceChild(surroundingSpan, urlInput);
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