class PlacesController < ActionController::Base
  layout "application"

  def vote
    @place = Place.not_rated_by(uuid).random.first || Place.random.first
    @vote = @place.votes.new(uuid: uuid)
    @last_rated_place = PlaceWithRating.new(latest_place_with_rating) if latest_place_with_rating
  end

  def leaderboard
    @leaderboard = LeaderboardPresenter.new
  end

  private

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end

  def just_rated_place_id
    session[:just_rated_place_id]
  end

  def latest_place_with_rating
    just_rated_place = Place.where(id: just_rated_place_id).first
    return unless just_rated_place

    {
      "place_id" => just_rated_place_id,
      "score" => just_rated_place.votes.average(:rating),
      "vote_count" => just_rated_place.votes.count
    }
  end
end
