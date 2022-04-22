RSpec.describe "The FAQ page" do
  scenario "loads successfully" do
    visit faq_path

    expect(page).to have_content("What is this site?")
    expect(page).to have_content("How do I get in touch?")
  end
end
