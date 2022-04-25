RSpec.describe "Downloading council data" do
  scenario "users can download prepared TSV data files" do
    # Given at least one local authority exists
    LocalAuthority.create(name: "The Shire")

    # When I go to the data page
    visit data_downloads_path

    # Then I can download the data for that area
    expect(page).to have_content("The Shire")
  end
end
