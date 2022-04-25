RSpec.describe PlacePresenter, type: :presenter do
  let(:place) { FactoryBot.build(:place) }
  let(:votes) { double(:votes, average: 8.66667, count: 7) }

  before do
    allow(place).to receive(:votes).and_return(votes)
  end

  describe "score" do
    it "is a string representation of the average rating rounded to a 2-decimal float" do
      expect(PlacePresenter.new(place).score).to eql("8.67")
    end

    context "when there are no significant digits after the decimal point" do
      it "is a string representation of the average rating as an integer" do
        allow(votes).to receive(:average).and_return(9.0001)

        expect(PlacePresenter.new(place).score).to eql("9")
      end
    end
  end

  describe "vote_count" do
    it "is the total number of votes for the place" do
      expect(PlacePresenter.new(place).vote_count).to eql(7)
    end
  end
end
