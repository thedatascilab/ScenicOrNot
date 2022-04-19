class PlacesController < ActionController::Base
  layout "application"

  def show
    @place = Place.left_joins(:votes)
      .where("votes.id IS NULL OR votes.uuid != '#{uuid}'")
      .order(Arel.sql("RANDOM()"))
      .first
    @vote = @place.votes.new(uuid: uuid)
  end

  private

  def uuid
    session[:uuid] ||= SecureRandom.uuid
  end
end
