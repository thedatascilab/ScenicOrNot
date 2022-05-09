require "csv"

votes_filename = File.join(
  Rails.root,
  "db",
  "data",
  "votes.csv"
)

SmarterCSV.process(votes_filename, chunk_size: 1000) do |chunk|
  rows = []

  chunk.each do |row|
    rows << {
      id: row[:id].to_i,
      place_id: row[:place],
      uuid: row[:uuid],
      rating: row[:rating],
      created_at: DateTime.parse(row[:date_submitted])
    }
  end

  unique_rows = rows.uniq { |vote| [vote[:place_id], vote[:uuid]] }

  Vote.import unique_rows, on_duplicate_key_update: {conflict_target: [:place_id, :uuid]}
end
