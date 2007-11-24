
	function loginChanged() {
		var select = document.getElementById('siteselect');
		var site = select.options[select.selectedIndex].value;
		var loginValue = document.getElementById('login').value;
		
		var openidurl = "";
		
		if (loginValue) {
			switch (site) {
				case "wordpress":
					openidurl = "http://" + loginValue + ".wordpress.com/";
					break;
				case "livejournal":
					openidurl = "http://" + loginValue + ".livejournal.com/";
					break;
				case "vox":
					openidurl = "http://" + loginValue + ".vox.com/";
					break;
				case "technorati":
					openidurl = "http://technorati.com/people/technorati/" + loginValue;
					break;
				case "aim":
					openidurl = "http://openid.aol.com/" + loginValue;
					break;
			}
		}
		document.getElementById('openid_url').value = openidurl;
		
		return true;
	}