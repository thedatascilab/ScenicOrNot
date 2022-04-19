require "csv"

votes_filename = File.join(
  Rails.root,
  "db",
  "data",
  "development",
  "votes.csv"
)

CSV.foreach(votes_filename, headers: true, encoding: "BOM|UTF-8") do |row|
  params = {
    place_id: row["place"],
    uuid: row["uuid"],
    rating: row["rating"],
    created_at: DateTime.parse(row["date_submitted"])
  }

  Vote.find_or_create_by(id: row["id"].to_i).update!(params)
end
