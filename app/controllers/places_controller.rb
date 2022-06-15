class PlacesController < ActionController::Base
  layout "application"

  def vote
    @place = PlacePicker.new(uuid).place
    @vote = @place.votes.new(uuid: uuid)
    @last_rated_place = PlacePresenter.new(just_rated_place) if just_rated_place
  end

  def leaderboard
    leaderboard = Leaderboard.load_or_new
    @leaderboard = LeaderboardPresenter.new(leaderboard)
  end

  def show
    @place = PlacePresenter.new(Place.find(params[:id]))
  end

  private

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end

  def just_rated_place_id
    @just_rated_place_id ||= session.delete(:just_rated_place_id)
  end

  def just_rated_place
    # we don't want a 404 error if somehow the place cannot be found
    Place.where(id: just_rated_place_id).first if just_rated_place_id
  end
end
