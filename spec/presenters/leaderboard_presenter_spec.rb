require "rails_helper"

RSpec.describe LeaderboardPresenter, type: :presenter do
  describe "top_five" do
    let(:result) {
      {
        "place_id" => 123,
        "score" => 9.5,
        "vote_count" => 7
      }
    }
    let(:place) { FactoryBot.build(:place) }
    let(:leaderboard) { double(:leaderboard, most_scenic_places: [result]) }

    before do
      allow(Place).to receive(:find).and_return(place)
    end

    it "returns an array with the top five places and their stats" do
      top_place = LeaderboardPresenter.new(leaderboard).top_five.first

      expect(top_place.score).to eql("9.5")
      expect(top_place.vote_count).to eql(7)
      expect(top_place.title).to eql(place.title)
    end
  end

  describe "bottom_five" do
    let(:result) {
      {
        "place_id" => 123,
        "score" => 1.5,
        "vote_count" => 7
      }
    }
    let(:place) { FactoryBot.build(:place) }
    let(:leaderboard) { double(:leaderboard, least_scenic_places: [result]) }

    before do
      allow(Place).to receive(:find).and_return(place)
    end

    it "returns an array with the bottom five places and their stats" do
      bottom_place = LeaderboardPresenter.new(leaderboard).bottom_five.first

      expect(bottom_place.score).to eql("1.5")
      expect(bottom_place.vote_count).to eql(7)
      expect(bottom_place.title).to eql(place.title)
    end
  end

  describe "percentage_rated" do
    let(:leaderboard) { double(:leaderboard, percentage_rated: 85.33) }

    it "displays the percentage_rated rounded to a 2-decimal float" do
      expect(LeaderboardPresenter.new(leaderboard).percentage_rated).to eql("85.33%")
    end
  end
end
