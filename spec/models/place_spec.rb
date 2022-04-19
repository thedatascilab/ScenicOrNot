require "rails_helper"

RSpec.describe Place, type: :model do
  context "associations" do
    it { should have_many(:votes) }
  end

  it "should exist" do
    place = build(:place)

    expect(place).to be_a_kind_of(Place)
  end

  describe ".not_rated_by" do
    let(:uuid) { SecureRandom.uuid }

    it "returns places without votes from the specified uuid" do
      place_without_votes = FactoryBot.create(:place)
      place_with_vote_from_other = FactoryBot.create(:place)
      place_with_votes_from_me_and_other = FactoryBot.create(:place)

      FactoryBot.create(:vote, place: place_with_vote_from_other)
      FactoryBot.create(:vote, place: place_with_votes_from_me_and_other)
      FactoryBot.create(:vote, uuid: uuid, place: place_with_votes_from_me_and_other)

      expect(Place.not_rated_by(uuid).pluck(:id)).to match_array([
        place_without_votes.id,
        place_with_vote_from_other.id
      ])
    end
  end
end
