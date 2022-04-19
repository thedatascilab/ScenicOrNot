RSpec.describe "A user rates a place" do
  scenario "a successful vote" do
    # Given that at least a place exists in the database
    _place = FactoryBot.create(:place, title: "Hilly Mountainfordshire")

    # When I go to the home page
    visit root_path

    # And I rate the place
    click_on "5"

    # Then I get a message telling me what I've just rated
    expect(page).to have_content("You've just rated: Hilly Mountainfordshire")
    expect(page).to have_content("Your rating: 5")
  end
end
