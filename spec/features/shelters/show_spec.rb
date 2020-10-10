require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the /shelters/:id path" do
    it "I see a shelter with that ID and data" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
    end

    it "I see a link to view pets" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link('View Pets')
      click_link('View Pets')

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    end

    it "I see a link to edit the shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_link('Update Shelter')
      click_link('Update Shelter')

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    end

    it "I see a link to delete the shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      shelter_2 = Shelter.create(name: 'City of Austin Animal Shelter', address: '453 City St', city: 'Austin', state: 'TX', zip:'78754')

      visit "/shelters/#{shelter_1.id}"
      click_link "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).not_to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
