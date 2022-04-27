class Leaderboard
  NUM_PLACES_IN_TOP = 5

  DEFAULT_OPTIONS = {
    min_score: 9,
    max_score: 2,
    min_vote_count: 3
  }

  FALLBACK_OPTIONS = {
    min_score: 5,
    max_score: 3,
    min_vote_count: 1
  }

  def most_scenic_places
    results = ActiveRecord::Base.connection.execute(top_query)
    if results.entries.size < NUM_PLACES_IN_TOP
      results = ActiveRecord::Base.connection.execute(top_query(FALLBACK_OPTIONS))
    end
    results.entries
  end

  def least_scenic_places
    results = ActiveRecord::Base.connection.execute(bottom_query)
    if results.entries.size < NUM_PLACES_IN_TOP
      results = ActiveRecord::Base.connection.execute(bottom_query(FALLBACK_OPTIONS))
    end
    results.entries
  end

  private

  def top_query(options = DEFAULT_OPTIONS)
    "SELECT place_id, count(place_id) AS vote_count, avg(rating) AS score FROM votes " \
    "GROUP BY place_id HAVING avg(rating) > #{options[:min_score]} AND count(place_id) >= #{options[:min_vote_count]} " \
    "ORDER BY score DESC, vote_count DESC LIMIT #{NUM_PLACES_IN_TOP}"
  end

  def bottom_query(options = DEFAULT_OPTIONS)
    "SELECT place_id, count(place_id) AS vote_count, avg(rating) AS score FROM votes " \
    "GROUP BY place_id HAVING avg(rating) <= #{options[:max_score]} AND count(place_id) >= #{options[:min_vote_count]} " \
    "ORDER BY score ASC, vote_count DESC LIMIT #{NUM_PLACES_IN_TOP}"
  end
end
