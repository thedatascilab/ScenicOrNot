RSpec.describe "The Cookies page" do
  scenario "loads successfully" do
    visit cookies_path

    expect(page).to have_content("Cookies")
    expect(page).to have_content("To make our service easier or more useful")
  end
end
