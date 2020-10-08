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

      fill_in "shelter[name]", with: "Dumb Friends League"
      fill_in "shelter[address]", with: "9903 Faithful Rd"
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "80382"
      click_button "Edit Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Dumb Friends League")
    end
  end
end

# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
