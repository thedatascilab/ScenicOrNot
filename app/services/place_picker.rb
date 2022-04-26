class PlacePicker
  def initialize(uuid)
    @uuid = uuid
  end

  def place
    goldilock_place || Place.not_rated_by(uuid).random.first || Place.random.first
  end

  def goldilock_place(min_vote_count: 0, max_vote_count: 3)
    Place.not_rated_by(uuid)
      .joins(:votes)
      .group("places.id")
      .having("count('votes.place_id') > :min AND count('votes.place_id') <= :max", {min: min_vote_count, max: max_vote_count})
      .random.first
  end

  private

  attr_reader :uuid
end
