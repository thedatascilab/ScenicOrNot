require "csv"

votes_filename = File.join(
  Rails.root,
  "db",
  "data",
  "votes.csv"
)

rows = []

CSV.foreach(votes_filename, headers: true, encoding: "BOM|UTF-8") do |row|
  rows << {
    id: row["id"].to_i,
    place_id: row["place"],
    uuid: row["uuid"],
    rating: row["rating"],
    created_at: DateTime.parse(row["date_submitted"])
  }
end

unique_rows = rows.uniq { |vote| [vote[:place_id], vote[:uuid]] }

Vote.upsert_all(unique_rows, unique_by: :id)
