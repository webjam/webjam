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
		"Wordpress": "http://<username>.wordpress.com/",
		"Blogger": "http://<username>.blogger.com",
		"Flickr": "http://www.flickr.com/photos/<username>",
		"Technorati": "http://technorati.com/people/<username>/",
		"AOL": "http://openid.aol.com/<username>",
		"Live Journal": "http://<username>.livejournal.com/"
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
		Appends a fieldset to the input's form with some helpers for constructing OpenID URLs for common
    services.

		The fieldset that's generated looks like:
			<fieldset class="contruct-openid">
				<p class="explanation">...</p>
				<select>
					<option>Wordpress</option>
					<option>...</option>
				</select>
				<p class="input">http://<input type="text" value="" />.wordpress.com</p>
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
		fieldset.appendChild(service);
		
		var option = document.createElement("option");
		option.value = "";
		option.appendChild(document.createTextNode("Choose a service"));
		service.appendChild(option);		
		
		for (var serviceName in openIdProviders) {
			var option = document.createElement("option");
			option.value = serviceName;
			option.appendChild(document.createTextNode(serviceName));
			service.appendChild(option);
		}
		
		var inputParagraph = document.createElement("p");
		inputParagraph.className = "input";

		var preInputText = document.createTextNode("http://");
		inputParagraph.appendChild(preInputText);
		
		var input = document.createElement("input");
		input.type = "text";
		input.value = "";
		inputParagraph.appendChild(input);

		var postInputText = document.createTextNode(".somewhere.com");
		inputParagraph.appendChild(postInputText);

		var updateUrlInput = function() {
			var urlTemplate = openIdProviders[service.value];
			urlInput.value = urlTemplate.replace("<username>", input.value);
		}
		
		addEvent(input, "keyup", updateUrlInput);
		
		addEvent(service, "change", function() {
			if (service.value == "" && inputParagraph.parentNode) {
				inputParagraph.parentNode.removeChild(inputParagraph);
			}

			var urlTemplate = openIdProviders[service.value];
			
			preInputText.data = urlTemplate.split("<username>")[0];
			postInputText.data = urlTemplate.split("<username>")[1];

			fieldset.appendChild(inputParagraph);
			
			updateUrlInput();
		});
		
		form.appendChild(fieldset);
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