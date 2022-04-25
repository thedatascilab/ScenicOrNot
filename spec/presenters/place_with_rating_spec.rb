RSpec.describe PlaceWithRating, type: :presenter do
  describe "score" do
    let(:query_result) {
      {
        "place_id" => 123,
        "score" => 8.66667,
        "vote_count" => 7
      }
    }
    let(:place) { FactoryBot.build(:place) }

    before do
      allow(Place).to receive(:find).and_return(place)
    end

    it "is rounded to a 2-decimal float" do
      expect(PlaceWithRating.new(query_result).score).to eql("8.67")
    end

    it "is shown as an integer if there are no significant digits after the decimal point" do
      query_result["score"] = 9.0001

      expect(PlaceWithRating.new(query_result).score).to eql("9")
    end
  end
end
