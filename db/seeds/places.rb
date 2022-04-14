require "csv"

places_filename = File.join(
  Rails.root,
  "db",
  "data",
  "development",
  "places.csv"
)

CSV.foreach(places_filename, headers: true, encoding: "BOM|UTF-8") do |row|
  geograph_id = row["geograph_uri"].split("/").last
  image_code = row["image_uri"].split("/").last
  image_uri = [ENV["S3_HOSTNAME"], image_code].join("/")

  params = {
    geograph_id: geograph_id,
    title: row["title"],
    description: row["description"],
    subject: row["subject"],
    creator: row["creator"],
    creator_uri: row["creator_uri"],
    date_submitted: DateTime.parse(row["date_submitted"]),
    lat: row["lat"],
    lon: row["lon"],
    gridsquare: row["gridsquare"],
    license_uri: row["license_uri"],
    format: row["format"],
    vote_count: row["votes"],
    random: row["random"],
    width: row["width"],
    height: row["height"],
    aspect: row["aspect"],
    geograph_image_uri: row["image_uri"],
    image_uri: image_uri
  }

  Place.find_or_create_by(id: row["id"].to_i).update!(params)
end
