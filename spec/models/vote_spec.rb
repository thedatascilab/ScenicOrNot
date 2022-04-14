require "rails_helper"

RSpec.describe Vote, type: :model do
  context "associations" do
    it { should belong_to(:place) }
  end

  context "validations" do
    it "should make sure one user cannot vote more than once on a specific place" do
      uuid = SecureRandom.uuid

      place1 = create(:place)
      place2 = create(:place)

      first_place1_vote = create(:vote, place: place1, uuid: uuid)
      second_place1_vote = build(:vote, place: place1, uuid: uuid)

      place2_vote = build(:vote, place: place2, uuid: uuid)

      expect(first_place1_vote.valid?).to be_truthy
      expect(second_place1_vote.valid?).to be_falsey

      expect(place2_vote.valid?).to be_truthy
    end
  end
end
