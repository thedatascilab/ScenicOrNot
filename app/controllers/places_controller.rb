class PlacesController < ActionController::Base
  layout "application"

  def show
    @place = Place.not_rated_by(uuid).random.first || Place.random.first
    @vote = @place.votes.new(uuid: uuid)
  end

  private

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end
end
