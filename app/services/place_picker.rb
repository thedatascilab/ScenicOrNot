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
    goldilock_place_ids.presence || place_ids_not_rated_by_user.presence || all_active_place_ids
  end

  def goldilock_place_ids(min_vote_count: 0, max_vote_count: 3)
    Place.active.not_rated_by(uuid)
      .joins(:votes)
      .group("places.id")
      .having("count('votes.place_id') > :min AND count('votes.place_id') <= :max", {min: min_vote_count, max: max_vote_count})
      .limit(10)
      .pluck(:id)
  end

  def place_ids_not_rated_by_user
    Place.active.not_rated_by(uuid).pluck(:id)
  end

  def all_active_place_ids
    Place.active.pluck(:id)
  end
end
