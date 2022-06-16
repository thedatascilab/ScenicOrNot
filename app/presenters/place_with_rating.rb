class PlaceWithRating
  include ActionView::Helpers::NumberHelper

  attr_reader :place, :vote_count

  delegate :id, :title, :image_location, :map_link, :to_param, to: :place

  def initialize(result)
    @place = Place.find(result["place_id"])
    @score = result["score"]
    @vote_count = result["vote_count"]
  end

  def score
    number_with_precision(@score, precision: 2, strip_insignificant_zeros: true)
  end
end
