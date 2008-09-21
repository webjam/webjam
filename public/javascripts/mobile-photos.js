$(document).ready(function() {
  $("ul.photo-list li a").click(function() {
    var currentZoomedImage = $(".zoomedImage");
    if (currentZoomedImage) {
      currentZoomedImage.remove();
    }
    
    var $thumbnailAnchor = $(this);
    $thumbnailAnchor.append($("<div class='spinner'></div>"));

    var imageSrc = $thumbnailAnchor.children("img").attr("src").replace("_s.jpg","_m.jpg");
    var $image = $("<img/>").attr("src", imageSrc);

    var $imageContainer = $("<div class='zoomedImage'></div>");
    var $closeLayer = $("<div class='close'/>");
    var $imageInner = $("<div class='inner'></div>");
    var $externalLink = $("<div class='externalLink'><a href='#' class='button'><span class='text'>" + $thumbnailAnchor.find(".title").text() + $thumbnailAnchor.find(".by").text() + "</span>"  + "</a>");
    
    $imageInner.append($image).append($closeLayer).append($externalLink);
    $imageContainer.append($imageInner);

    var close = function() {
      $imageContainer.remove();
      return false;
    }
    
    $closeLayer.click(close);
    $image.click(close);
    
    $(document).data('latestImageContainer', $imageContainer);
    
    $image.load(function() {
      $thumbnailAnchor.children(".spinner").remove();
      // Check for race condition with another image loading
      if ($(document).data('latestImageContainer') == $imageContainer) {
        $imageInner.css({height:$image.attr("height"), width:$image.attr("width")});
        $imageContainer.css('top', ($(window).height() / 2) - ($image.attr("height") / 2) + window.pageYOffset - 25);
        $(document.body).append($imageContainer);
      }
    });

    return false;
  });
});
