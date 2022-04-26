require "rails_helper"

RSpec.describe PlacePicker, type: :service do
  let(:uuid) { SecureRandom.uuid }
  let(:place_rated_by_user) { FactoryBot.create(:place) }

  before do
    FactoryBot.create(:vote, place: place_rated_by_user, uuid: uuid)
  end

  describe "place" do
    context "there is at least one place with 1-3 votes that the given user has not rated" do
      let(:goldilock_place) { FactoryBot.create(:place) }

      before do
        FactoryBot.create_list(:vote, 3, place: goldilock_place)

        place_with_many_votes = FactoryBot.create(:place)
        FactoryBot.create_list(:vote, 10, place: place_with_many_votes)

        # places with no votes
        FactoryBot.create_list(:place, 10)
      end

      it "returns the place with 1-3 votes not already rated by the user" do
        expect(PlacePicker.new(uuid).place).to eql(goldilock_place)
      end
    end

    context "there are no places with 1-3 votes that the given user has not rated" do
      context "but there are places that the given user has not rated" do
        let(:not_rated_by_user) { FactoryBot.create(:place) }

        before do
          FactoryBot.create_list(:vote, 3, place: not_rated_by_user)
        end

        it "returns a place that the user has not rated" do
          expect(PlacePicker.new(uuid).place).to eql(not_rated_by_user)
        end
      end

      context "and there are no places that the user has not rated" do
        it "returns a random place" do
          expect(PlacePicker.new(uuid).place).to_not be_nil
        end
      end
    end
  end
end
