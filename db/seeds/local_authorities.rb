require "csv"

councils_filename = File.join(
  Rails.root,
  "db",
  "data",
  "local_authorities.tsv"
)

CSV.foreach(councils_filename, headers: true, encoding: "BOM|UTF-8", col_sep: "\t") do |row|
  params = {
    name: row["name"]
  }

  LocalAuthority.find_or_create_by(name: row["name"].squish).update!(params)
end
