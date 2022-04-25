module PlaceHelper
  def place_thumbnail(place, thumbnail_is_link: false)
    thumbnail = "<img src='#{place.image_uri}' width='90px' alt='#{place.title}' />".html_safe
    return thumbnail unless thumbnail_is_link

    link_to(thumbnail, place_path(place.id))
  end
end
