/*
  Called like so:
   $("ul.photos").mobilePhotoNavigator(<JSON>, "/", 1, 10);
*/
jQuery.fn.mobilePhotoNavigator = function(photos, photos_url, current_page, total_pages) {
  if (!photos || photos.length == 0) return;

  var PhotoNavigator = function(element) {
    this.element = $(element);
    this.element.addClass("photoNavigator");
    this.nextPhotoControl = this.addControl(this.nextPhoto, "control next", "Next photo");
    this.previousPhotoControl = this.addControl(this.previousPhoto, "control previous", "Previous photo");
    this.loadingOverlay = jQuery("<div class='loadingOverlay'></div>").hide().appendTo(this.element);
  };
  jQuery.extend(PhotoNavigator.prototype, {
    showLoadingOverlay: function() { this.loadingOverlay.show(); },
    hideLoadingOverlay: function() { this.loadingOverlay.hide(); },
    addControl: function(clickFunction, cssClass, title) {
      var control = jQuery("<a href='void:(0)'></a>").attr("title", title).addClass(cssClass);
      control.click(function(e) { clickFunction(e); return false; }).appendTo(this.element);
      return control;
    },
    nextPhoto: function() { alert("Next photo!"); },
    previousPhoto: function() { alert("Previous photo!"); }
  });
  
  this.each(function() {
    var photoNavigator = new PhotoNavigator(this);
    this.data('photoNavigator', photoNavigator);
  });
  
  return jQuery;
};