require "rails_helper"

RSpec.describe PlacePicker, type: :service do
  let(:uuid) { SecureRandom.uuid }
  let(:place_rated_by_user) { FactoryBot.create(:place) }

  before do
    FactoryBot.create(:vote, place: place_rated_by_user, uuid: uuid)
  end

  describe "place" do
    context "there is at least one place that the given user has not rated" do
      let!(:place_not_rated_by_user) { FactoryBot.create(:place) }

      it "returns the place not already rated by the user" do
        expect(PlacePicker.new(uuid).place).to eql(place_not_rated_by_user)
      end
    end

    context "there are no places that the given user has not rated" do
      it "returns a random place" do
        expect(PlacePicker.new(uuid).place).to_not be_nil
      end
    end

    it "never selects a place that is not active_on_geograph" do
      place_rated_by_user.update(active_on_geograph: false)

      expect(PlacePicker.new(uuid).place).to be_nil
    end
  end
end
