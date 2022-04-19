RSpec.describe "A user rates a place" do
  scenario "a successful vote" do
    # Given that at least two places exist in the database
    FactoryBot.create_list(:place, 2)

    # When I go to the home page
    visit root_path

    # And I rate the place
    click_on "5"

    # Then I get a message telling me what I've just rated
    voted_place = Vote.last.place
    expect(page).to have_content("You've just rated: #{voted_place.title}")
    expect(page).to have_content("Your rating: 5")

    # And I am shown another place to rate
    other_place = Place.where.not(id: voted_place.id).first
    expect(page).to have_content("Photo by #{other_place.creator}")
  end
end
