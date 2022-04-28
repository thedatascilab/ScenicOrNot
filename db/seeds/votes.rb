require "csv"

votes_filename = File.join(
  Rails.root,
  "db",
  "data",
  "development",
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

Vote.upsert_all(rows, unique_by: :id)
