require "csv"

class ExportPlacesWithVotes
  def tsv_data
    CSV.generate(col_sep: "\t") do |csv|
      csv << csv_headers
      places_data.each do |row|
        csv << transform_data(row)
      end
    end
  end

  private

  def transform_data(entry)
    image_number = entry["image_uri"].match(image_number_regex)[1]

    [
      entry["lat"],
      entry["lon"],
      entry["avg"].round(4),
      entry["variance"].round(4),
      entry["ratings"],
      "https://www.geograph.org.uk/photo/#{image_number}"
    ]
  end

  def csv_headers
    ["Lat", "Lon", "Average", "Variance", "Votes", "Geograph URI"]
  end

  def places_data
    @places_data ||= ActiveRecord::Base.connection.execute(places_query).entries
  end

  def image_number_regex
    @image_number_regex ||= Regexp.new('([1-9]\d*)_')
  end

  def places_query
    "SELECT places.id, lat, lon, avg(rating), var_pop(rating) AS variance, string_agg(rating::text, ',') AS ratings, image_uri " \
    "FROM votes JOIN places ON votes.place_id = places.id " \
    "WHERE active_on_geograph = true " \
    "GROUP BY places.id HAVING count(rating) >= 3"
  end
end
