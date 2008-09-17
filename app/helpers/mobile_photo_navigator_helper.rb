module MobilePhotoNavigatorHelper
  def mobilePhotoNavigatorInitJavascript(jquery_selector, paginated_photos, photo_request_url)
    "$(document).ready(function() {$('#{jquery_selector}').mobilePhotoNavigator(#{paginated_photos.to_json}, '#{photo_request_url}', #{paginated_photos.current_page}, #{paginated_photos.total_pages}) });"
  end
end
