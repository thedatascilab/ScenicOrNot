RSpec.describe "The leaderboard" do
  scenario "shows the highest and lowest rated places" do
    # Given that a place with at least 3 ratings averaging above 9 exists
    most_scenic_place = FactoryBot.create(:place, title: "The Shire")
    FactoryBot.create_list(:vote, 3, place: most_scenic_place, rating: 10)

    # And a place with at least 3 ratings equal to 1 exists
    least_scenic_place = FactoryBot.create(:place, title: "Saruman's Tower")
    FactoryBot.create_list(:vote, 3, place: least_scenic_place, rating: 1)

    # And enough ratings all along the scale exist
    FactoryBot.create_list(:vote, 100)

    # When I go to the leaderboard page
    visit leaderboard_path

    # Then I can see the top 5 places
    expect(page).to have_content("Leaderboard")
    expect(page).to have_content("Top 5")

    within("#most-scenic") do
      expect(page).to have_content("The Shire")
      expect(page).to have_content("Rating: 10 (from 3 votes)")
    end

    # And I can see the bottom 5 places
    expect(page).to have_content("Bottom 5")

    within("#least-scenic") do
      expect(page).to have_content("Saruman's Tower")
      expect(page).to have_content("Rating: 1 (from 3 votes)")
    end
  end
end
