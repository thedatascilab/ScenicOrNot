class PlacePicker
  def initialize(uuid)
    @uuid = uuid
  end

  def place
    eligible_places.present? ? Place.find(eligible_places.sample) : nil
  end

  private

  attr_reader :uuid

  def eligible_places
    place_ids_not_rated_by_user.presence || all_active_place_ids
  end

  def place_ids_not_rated_by_user
    Place.active.not_rated_by(uuid).pluck(:id)
  end

  def all_active_place_ids
    Place.active.pluck(:id)
  end
end
