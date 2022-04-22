class PlacesController < ActionController::Base
  layout "application"

  def vote
    @place = Place.not_rated_by(uuid).random.first || Place.random.first
    @vote = @place.votes.new(uuid: uuid)
  end

  def leaderboard
    @leaderboard = LeaderboardPresenter.new
  end

  private

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end
end
