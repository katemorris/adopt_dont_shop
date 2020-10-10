require 'rails_helper'

describe "As a visitor" do
  describe "when I visit a shelter show page" do
    it "I see a link to update the shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_link("Update Shelter")
    end

    it "when the Update Shelter link is clicked, I go to the shelter page and see a form" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      visit "/shelters/#{shelter_1.id}"
      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
      expect(page).to have_selector("form")
    end

    it "I fill out the form and see the new shelter on /shelters" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      visit "/shelters/#{shelter_1.id}/edit"

      fill_in :name, with: "Dumb Friends League"
      fill_in :address, with: "9903 Faithful Rd"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80382"
      click_button "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Dumb Friends League")
    end
  end
end
