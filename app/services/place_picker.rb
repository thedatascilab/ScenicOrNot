class PlacePicker
  def initialize(uuid)
    @uuid = uuid
  end

  def place
    eligible_places.first
  end

  private

  attr_reader :uuid

  def eligible_places
    return goldilock_places if goldilock_places.any?
    return places_not_rated_by_user if places_not_rated_by_user.any?

    all_active_places
  end

  def goldilock_places(min_vote_count: 0, max_vote_count: 3)
    Place.active.not_rated_by(uuid)
      .joins(:votes)
      .group("places.id")
      .having("count('votes.place_id') > :min AND count('votes.place_id') <= :max", {min: min_vote_count, max: max_vote_count})
      .random
  end

  def places_not_rated_by_user
    Place.active.not_rated_by(uuid).random
  end

  def all_active_places
    Place.active.random
  end
end
