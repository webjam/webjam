$(document).ready(function() {
  $("ul.photo-list li a").click(function() {
    var $currentZoomedImage = $(".zoomedImage");
    if ($currentZoomedImage.length != 0) {
      $currentZoomedImage.remove();
    }
    
    var $thumbnailAnchor = $(this);
    $thumbnailAnchor.append($("<div class='spinner'></div>"));

    var imageSrc = $(this).children("img").attr("src").replace("_s.jpg","_m.jpg");
    var $image = $("<img/>").attr("src", imageSrc);

    var $imageContainer = $("<div class='zoomedImage' style='display:none'></div>");
    var $closeLayer = $("<div class='close'/>");
    var $imageInner = $("<div class='inner'></div>");
    var $externalLink = $("<div class='externalLink'><a href='#' class='button'>View on flickr</a>");
    $imageInner.append($image).append($closeLayer);
    $imageContainer.append($imageInner).append($externalLink);

    var close = function() {
      $(document.body).data('zoomedImage', null);
      $imageContainer.remove();
      return false;
    }
    
    $closeLayer.click(close);
    $image.click(close);
    
    $image.load(function() {
      console.log("window height: " + $(window).height());
      console.log("image height: " + $image.attr("height"));
      console.log("window.pageYOffset: " + window.pageYOffset);
      $imageContainer.css('top', ($(window).height() / 2) - ($image.attr("height") / 2) + window.pageYOffset - 25);
      $thumbnailAnchor.children(".spinner").remove();
      $imageContainer.show();
    });
    
    $(document.body).append($imageContainer);

    return false;
  });
});
