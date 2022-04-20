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

  context "most and least scenic places" do
    let(:most_scenic_place) { FactoryBot.create(:place) }
    let(:least_scenic_place) { FactoryBot.create(:place) }

    before do
      FactoryBot.create_list(:vote, 3, place: most_scenic_place, rating: 10)
      FactoryBot.create_list(:vote, 3, place: least_scenic_place, rating: 1)
      FactoryBot.create_list(:vote, 5, rating: 8)
      FactoryBot.create_list(:vote, 5, rating: 3)
    end

    describe ".most_scenic_places" do
      it "returns the top 5 rated places" do
        top_five = Vote.most_scenic_places

        expect(top_five.size).to eql(5)
        expect(top_five.first).to match(hash_including(
          "place_id" => most_scenic_place.id,
          "score" => 10,
          "vote_count" => 3
        ))
      end
    end

    describe ".least_scenic_places" do
      it "returns the bottom 5 rated places" do
        bottom_five = Vote.least_scenic_places

        expect(bottom_five.size).to eql(5)
        expect(bottom_five.first).to match(hash_including(
          "place_id" => least_scenic_place.id,
          "score" => 1,
          "vote_count" => 3
        ))
      end
    end
  end
end
