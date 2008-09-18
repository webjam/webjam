/*
  Called like so:
   $("ul.photos").mobilePhotoNavigator(<JSON>, "/", 1, 10);
*/
jQuery.fn.mobilePhotoNavigator = function(photoData, photos_url, current_page, total_pages) {
  if (!photoData || photoData.length == 0) return;

  var PhotoNavigator = function(element, photos) {
    this.element = $(element);
    this.element.addClass("photoNavigator");
    this.loadingOverlay = jQuery("<div class='loadingOverlay'></div>").hide().appendTo(this.element);
    this.photos = photos;
    this.currentPhotoIndex = 0;
    
    this.nextPhotoControl = this.addControl(this.nextPhoto, "control next", "Next photo");
    this.previousPhotoControl = this.addControl(this.previousPhoto, "control previous", "Previous photo");

    var navigator = this;
    this.nextPhotoControl.click(function(event) {
      event.preventDefault();
      navigator.navigateToNextPhoto();
    });
    this.previousPhotoControl.click(function(event) {
      event.preventDefault(); 
      navigator.navigateToPreviousPhoto();
    });

    this.updateControlState();
  };
  
  jQuery.extend(PhotoNavigator.prototype, {
    showLoadingOverlay: function() { this.loadingOverlay.show(); },
    hideLoadingOverlay: function() { this.loadingOverlay.hide(); },
    addControl: function(clickFunction, cssClass, title) {
      return jQuery("<a href='void:(0)'></a>").attr("title", title).addClass(cssClass).appendTo(this.element);
    },
    navigateToNextPhoto: function() {
      this.removeCurrentPhoto();
      this.element.append(this.nextPhoto().createElement());
      this.currentPhotoIndex++;
      this.updateControlState();
    },
    navigateToPreviousPhoto: function() {
      this.removeCurrentPhoto();
      this.element.append(this.previousPhoto().createElement());
      this.currentPhotoIndex--;
      this.updateControlState();
    },
    removeCurrentPhoto: function() {
      this.element.find(".photo").remove();
    },
    nextPhoto: function() {
      return this.photos[this.currentPhotoIndex+1];
    },
    previousPhoto: function() {
      return this.photos[this.currentPhotoIndex-1];
    },
    updateControlState: function() {
      if (this.nextPhoto()) this.nextPhotoControl.show();
      else this.nextPhotoControl.hide();
      if (this.previousPhoto()) this.previousPhotoControl.show();
      else this.previousPhotoControl.hide();
    }
  });
  
  var Photo = function(attributes) {
    jQuery.extend(this, attributes);
  };
  
  jQuery.extend(Photo.prototype, {
    createElement: function() {
      var element = jQuery("<div class='photo'></div>");

      jQuery("<img class='photo' />").attr({
        src: "http://farm" + this.farm + ".static.flickr.com/" + this.server + "/" + this.flickrid + "_" + this.secret + "_m.jpg",
        alt: this.title
      }).appendTo(element);

      jQuery("<a class='button'></a>").attr('href', this.url).html(this.title + " by " + this.realname).appendTo(element);
      
      return element;
    }
  });
  
  this.each(function() {
    var photos = jQuery.map(photoData, function(json) { return new Photo(json.flickr_photo); });
    var photoNavigator = new PhotoNavigator(this, photos);
    $(this).data('photoNavigator', photoNavigator);
  });
  
  return jQuery;
};