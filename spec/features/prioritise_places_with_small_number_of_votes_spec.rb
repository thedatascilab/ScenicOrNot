RSpec.describe "Prioritising places with a small but non-zero number of votes" do
  scenario "a user is shown a place that already has some votes so they can compare their rating" do
    # Given that a place with a certain number of votes exists
    goldilock_place = FactoryBot.create(:place, creator: "Goldilock")
    FactoryBot.create_list(:vote, 3, place: goldilock_place)

    # And a place with more votes than the cut-off number exists
    place_with_many_votes = FactoryBot.create(:place)
    FactoryBot.create_list(:vote, 10, place: place_with_many_votes)

    # And places with no votes exist
    FactoryBot.create_list(:place, 10)

    # When I go to the home page
    visit root_path

    # Then I am shown the place with the just-right number of votes
    expect(page).to have_content("Photo by Goldilock")
  end
end
