RSpec.describe "Home page shows a random place" do
  scenario "the home page shows a random place" do
    # Given that at least a place exists in the database
    _place = FactoryBot.create(:place, creator: "Namey Nameson")

    # When I go to the home page
    visit root_path

    # Then I expect to see a random place
    expect(page).to have_content("Photo by Namey Nameson")
    expect(page).to have_content("Licence")

    # And I expect to see a brief explanation of what ScenicOrNot is
    within("aside") do
      expect(page).to have_content("ScenicOrNot helps you to explore every corner")
    end
  end
end
