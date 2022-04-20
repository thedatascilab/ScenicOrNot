class PlacesController < ActionController::Base
  layout "application"

  def show
    @place = Place.order(Arel.sql("RANDOM()")).first
    @vote = @place.votes.new
  end
end
