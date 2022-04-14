require "rails_helper"

RSpec.describe Place, type: :model do
  context "associations" do
    it { should have_many(:votes) }
  end

  it "should exist" do
    place = build(:place)

    expect(place).to be_a_kind_of(Place)
  end
end
