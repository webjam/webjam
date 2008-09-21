$(document).ready(function() {
  $("ul.photo-list li a").click(function() {
    var $thumbnailAnchor = $(this);
    $thumbnailAnchor.addClass("loading");

    var imageSrc = $(this).children("img").attr("src").replace("_s.jpg","_m.jpg");
    var $image = $("<img/>").attr("src", imageSrc);
    
    var $closeLayer = $("<div class='close' style='display:none'/>").click(function() {$(this).parent().remove();});
    var $imageContainer = $("<div class='zoomedImage'/>").append($closeLayer).append($image);
    $imageContainer.css('top', window.pageYOffset);
    $imageContainer.click(function() {$(this).remove();});
    
    $image.load(function() {
      $thumbnailAnchor.removeClass("loading");
      $closeLayer.show();
    });
    
    $(document.body).append($imageContainer);

    return false;
  });
});
