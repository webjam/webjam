module MobilePhotoNavigatorHelper
  def mobilePhotoNavigatorInitJavascript(jquery_selector, photos)
    "$(document).ready(function() {$('#{jquery_selector}').mobilePhotoNavigator(#{photos.to_json})});"
  end
end
