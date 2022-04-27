class LeaderboardPresenter
  include ActionView::Helpers::NumberHelper

  TOTAL_UK_LAND_AREA_IN_SQ_KM = 241930

  def initialize(leaderboard: Leaderboard.new)
    @leaderboard = leaderboard
  end

  def top_five
    @leaderboard.most_scenic_places.map { |result| PlaceWithRating.new(result) }
  end

  def bottom_five
    @leaderboard.least_scenic_places.map { |result| PlaceWithRating.new(result) }
  end

  def percentage_coverage
    number_with_precision((Place.count.to_f / TOTAL_UK_LAND_AREA_IN_SQ_KM * 100), precision: 2, strip_insignificant_zeros: true)
  end
end
