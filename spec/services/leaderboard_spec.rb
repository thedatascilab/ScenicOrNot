RSpec.describe Leaderboard, type: :service do
  context "most and least scenic places" do
    let(:most_scenic_place) { FactoryBot.create(:place) }
    let(:least_scenic_place) { FactoryBot.create(:place) }

    before do
      FactoryBot.create_list(:vote, 3, place: most_scenic_place, rating: 10)
      FactoryBot.create_list(:vote, 3, place: least_scenic_place, rating: 1)
      FactoryBot.create_list(:vote, 5, rating: 8)
      FactoryBot.create_list(:vote, 5, rating: 3)
    end

    describe "most_scenic_places" do
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

    describe "least_scenic_places" do
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
  end
end
