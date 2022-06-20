require "rails_helper"

RSpec.describe ExportPlacesWithVotes, type: :service do
  describe "#tsv_data" do
    let(:expected_headers) { ["Lat", "Lon", "Average", "Variance", "Votes", "Geograph URI"].join("\t") }
    let(:place_with_enough_votes) { FactoryBot.create(:place, geograph_id: 7, lat: 51.4073, lon: -0.655554, image_uri: "000340_a49458b3.jpg", active_on_geograph: true) }

    before do
      FactoryBot.create(:vote, place: place_with_enough_votes, rating: 4)
      FactoryBot.create(:vote, place: place_with_enough_votes, rating: 6)
      FactoryBot.create(:vote, place: place_with_enough_votes, rating: 3)

      place_without_enough_votes = FactoryBot.create(:place)
      FactoryBot.create(:vote, place: place_without_enough_votes)
    end

    it "aggregates the data into a CSV-ready format" do
      tsv_data = ExportPlacesWithVotes.new.tsv_data

      expected_data =
        [
          expected_headers,
          [
            51.4073,
            -0.655554,
            0.43333e1,
            0.15556e1,
            "4,6,3",
            "https://www.geograph.org.uk/photo/340"
          ].join("\t")
        ].join("\n") + "\n"

      expect(tsv_data).to eq(expected_data)
    end

    it "does not include places that are not active_on_geograph" do
      place_with_enough_votes.active_on_geograph = false
      place_with_enough_votes.save!

      tsv_data = ExportPlacesWithVotes.new.tsv_data

      expect(tsv_data).to eq(expected_headers + "\n")
    end
  end
end
