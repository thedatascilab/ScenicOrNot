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

  describe ".with_enough_votes" do
    let(:place) { FactoryBot.create(:place) }
    let(:options) { {min_vote_count: 3} }

    before do
      FactoryBot.create_list(:vote, 3, place: place)
      # places without enough votes
      FactoryBot.create(:place)
      place_1_vote = FactoryBot.create(:place)
      FactoryBot.create(:vote, place: place_1_vote)
    end

    it "returns the places with at least n votes" do
      expect(Place.with_enough_votes(options)).to eql([place])
    end
  end

  describe "#map_link" do
    it "generates an OpenStreetMap link from the latitude and longitude" do
      place = build(:place)

      expect(place.map_link).to eql("https://www.openstreetmap.org/?mlat=#{place.lat}&mlon=#{place.lon}")
    end
  end

  describe "#image_location" do
    context "when there is an image hostname env var" do
      it "concatenates the image hostname with the image_uri" do
        ClimateControl.modify IMAGE_HOSTNAME: "http://test" do
          place = build(:place, image_uri: "fake_image_code.jpg")

          expect(place.image_location).to eql("http://test/fake_image_code.jpg")
        end
      end
    end

    context "when there is no image hostname env var" do
      it "concatenates the geograph_photos folder name with the image_uri" do
        ClimateControl.modify IMAGE_HOSTNAME: nil do
          place = build(:place, image_uri: "fake_image_code.jpg")

          expect(place.image_location).to eql("geograph_photos/fake_image_code.jpg")
        end
      end
    end
  end
end
