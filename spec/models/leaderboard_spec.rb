require "rails_helper"

RSpec.describe Leaderboard, type: :model do
  describe ".load_or_new" do
    let(:leaderboard) { Leaderboard.new }

    context "there is no file with the serialised leaderboard" do
      before do
        allow(Leaderboard).to receive(:new).and_return(leaderboard)
        allow(leaderboard).to receive(:from_json)
      end

      it "uses the live data to return the leaderboard" do
        leaderboard = Leaderboard.load_or_new(source_file: nil)

        expect(Leaderboard).to have_received(:new)
        expect(leaderboard).to_not have_received(:from_json)
      end
    end

    context "there is a file with the serialised leaderboard" do
      it "uses the file to generate the leaderboard" do
        leaderboard = Leaderboard.load_or_new(source_file: "spec/fixtures/leaderboard.json")

        expect(leaderboard.most_scenic_places.size).to eq(5)
        expect(leaderboard.most_scenic_places.first).to eq({"place_id" => 8, "vote_count" => 10, "score" => "8.8"})

        expect(leaderboard.least_scenic_places.size).to eq(5)
        expect(leaderboard.least_scenic_places.first).to eq({"place_id" => 38, "vote_count" => 10, "score" => "1.2"})

        expect(leaderboard.percentage_rated.round(2)).to eql(0.02)
      end
    end
  end

  context "determining the most and least scenic places" do
    let(:most_scenic_place) { FactoryBot.create(:place) }
    let(:least_scenic_place) { FactoryBot.create(:place) }

    before do
      FactoryBot.create_list(:vote, 3, place: most_scenic_place, rating: 10)
      FactoryBot.create_list(:vote, 3, place: least_scenic_place, rating: 1)
      FactoryBot.create_list(:vote, 5, rating: 8)
      FactoryBot.create_list(:vote, 5, rating: 3)
    end

    describe "#most_scenic_places" do
      it "returns the top 5 rated places" do
        top_five = Leaderboard.new.most_scenic_places

        expect(top_five.size).to eql(5)
        expect(top_five.first).to match(hash_including(
          "place_id" => most_scenic_place.id,
          "score" => 10,
          "vote_count" => 3
        ))
      end

      it "does not include any inactive places" do
        most_scenic_place.update(active_on_geograph: false)

        top_five = Leaderboard.new.most_scenic_places
        expect(top_five.collect { |r| r["place_id"] }).to_not include(most_scenic_place.id)
      end
    end

    describe "#least_scenic_places" do
      it "returns the bottom 5 rated places" do
        bottom_five = Leaderboard.new.least_scenic_places

        expect(bottom_five.size).to eql(5)
        expect(bottom_five.first).to match(hash_including(
          "place_id" => least_scenic_place.id,
          "score" => 1,
          "vote_count" => 3
        ))
      end

      it "does not include any inactive places" do
        least_scenic_place.update(active_on_geograph: false)

        bottom_five = Leaderboard.new.least_scenic_places
        expect(bottom_five.collect { |r| r["place_id"] }).to_not include(least_scenic_place.id)
      end
    end

    describe "#percentage_rated" do
      let(:places) { double(:places, count: 200000) }

      it "calculates the territory with places having received at least 3 votes" do
        allow(Place).to receive(:with_enough_votes).and_return(places)

        expect(Leaderboard.new.percentage_rated.round(2)).to eq(85.33)
      end
    end
  end

  describe "#attributes" do
    it "returns a hash with the attributes as string keys and nil values" do
      expect(Leaderboard.new.attributes).to eq({
        "most_scenic_places" => nil,
        "least_scenic_places" => nil,
        "percentage_rated" => nil
      })
    end
  end
end
