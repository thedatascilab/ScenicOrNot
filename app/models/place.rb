class Place < ApplicationRecord
  has_many :votes

  scope :active, -> { where(active_on_geograph: true) }
  scope :random, -> { order(Arel.sql("RANDOM()")) }
  scope :rated_by, ->(uuid) { joins(:votes).where(votes: {uuid: uuid}) }
  scope :not_rated_by, ->(uuid) { where.not(id: rated_by(uuid).pluck(:id)) }

  def map_link
    "https://www.openstreetmap.org/?mlat=#{lat}&mlon=#{lon}"
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def self.with_enough_votes(options)
    Place.joins(:votes)
      .group(:id)
      .having("count(place_id) >= :min_vote_count", {min_vote_count: options[:min_vote_count]})
      .entries
  end

  def image_location
    [ENV.fetch("IMAGE_HOSTNAME", "geograph_photos"), image_uri].join("/")
  end
end
