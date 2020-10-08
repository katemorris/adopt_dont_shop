require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the Shelter Index page" do
    it "the visitor sees a link to create a new Shelter" do
      visit "/shelters"

      expect(page).to have_link("New Shelter")
    end

    it "when the New Shelter link is clicked, the visitor goes to /shelters/new and sees a form" do
      visit "/shelters"
      click_on "New Shelter"

      expect(current_path).to eq('/shelters/new')
      expect(page).to have_selector("form")
    end

    it "I fill out the form and see the new shelter on /shelters" do
      visit "/shelters/new"

      fill_in "shelter[name]", with: "Dumb Friends League"
      fill_in "shelter[address]", with: "9903 Faithful Rd"
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "80382"
      click_button "Create Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Dumb Friends League")
    end
  end
end
