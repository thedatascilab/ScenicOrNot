class Vote < ApplicationRecord
  belongs_to :place

  validates_uniqueness_of :uuid, scope: :place

  def self.most_scenic_places
    results = ActiveRecord::Base.connection.execute(top_query)
    if results.entries.size < 5
      results = ActiveRecord::Base.connection.execute(top_query(min_score: 5, min_vote_count: 1))
    end
    results.entries
  end

  def self.least_scenic_places
    results = ActiveRecord::Base.connection.execute(bottom_query)
    if results.entries.size < 5
      results = ActiveRecord::Base.connection.execute(bottom_query(max_score: 5, min_vote_count: 1))
    end
    results.entries
  end

  def self.top_query(min_score: 9, min_vote_count: 3, num_places: 5)
    "SELECT place_id, count(place_id) AS vote_count, avg(rating) AS score FROM votes " \
    "GROUP BY place_id HAVING avg(rating) > #{min_score} AND count(place_id) >= #{min_vote_count} " \
    "ORDER BY score DESC, vote_count DESC LIMIT #{num_places}"
  end

  def self.bottom_query(max_score: 1, min_vote_count: 3, num_places: 5)
    "SELECT place_id, count(place_id) AS vote_count, avg(rating) AS score FROM votes " \
    "GROUP BY place_id HAVING avg(rating) <= #{max_score} AND count(place_id) >= #{min_vote_count} " \
    "ORDER BY score ASC, vote_count DESC LIMIT #{num_places}"
  end
end
