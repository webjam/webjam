$(document).ready(function() {
  $("ul.photo-list li a").click(function() {
    var bodyHider = $("#bodyHider")
    if (bodyHider.length == 0) {
      bodyHider = $("<div id='bodyHider' style='display:none'></div>").click(function() {
        $(this).show();
      });
      $(document.body).wrapInner(bodyHider);
    } else {
      bodyHider.hide();
    }
    var image = $("<img id='zoomed-photo' src='" + $(this).children("img").attr("src").replace("_s.jpg","_m.jpg") + "' style='width:100%' />").click(function() {
      $(this).remove();
      $("#bodyHider").show();
    });
    $(document.body).append(image);
    return false;
  });
});
