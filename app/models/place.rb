class Place < ApplicationRecord
  has_many :votes

  scope :random, -> { order(Arel.sql("RANDOM()")) }
  scope :rated_by, ->(uuid) { joins(:votes).where(votes: {uuid: uuid}) }
  scope :not_rated_by, ->(uuid) { where.not(id: rated_by(uuid).pluck(:id)) }

  def map_link
    "https://www.openstreetmap.org/?mlat=#{lat}&mlon=#{lon}"
  end
end
