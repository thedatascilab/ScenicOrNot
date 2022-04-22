RSpec.describe "A user rates a place" do
  scenario "a successful vote" do
    # Given that at least two places exist in the database
    FactoryBot.create_list(:place, 2)

    # When I go to the home page
    visit root_path

    # And I rate the place
    click_on "5"

    # Then I can see the place I've just rated and its overall score
    voted_place = Vote.last.place
    within("aside") do
      expect(page).to have_content("You've just rated:")
      expect(page).to have_content(voted_place.title)
      expect(page).to have_content("Rating: 5 (from 1 votes)")
    end

    # And I am shown another place to rate
    other_place = Place.where.not(id: voted_place.id).first
    expect(page).to have_content("Photo by #{other_place.creator}")
  end
end
