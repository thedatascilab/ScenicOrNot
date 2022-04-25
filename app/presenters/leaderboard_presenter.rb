class LeaderboardPresenter
  include ActionView::Helpers::NumberHelper

  TOTAL_UK_LAND_AREA_IN_SQ_KM = 241930

  def top_five
    Vote.most_scenic_places.map { |result| PlaceWithRating.new(result) }
  end

  def bottom_five
    Vote.least_scenic_places.map { |result| PlaceWithRating.new(result) }
  end

  def percentage_coverage
    number_with_precision((Place.count.to_f / TOTAL_UK_LAND_AREA_IN_SQ_KM * 100), precision: 2, strip_insignificant_zeros: true)
  end
end
