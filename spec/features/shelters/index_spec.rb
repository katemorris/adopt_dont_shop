require 'rails_helper'

describe "As a visitor" do
  describe "when the visitor visits the /shelters path" do
    it "the visitor sees the name of each shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      shelter_2 = Shelter.create(name: 'City of Austin Animal Shelter', address: '453 City St', city: 'Austin', state: 'TX', zip:'78754')

      visit '/shelters'

      expect(page).to have_content("#{shelter_1.name}")
      expect(page).to have_content("#{shelter_2.name}")
    end

    it "I expect to see a link to the edit page of a shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')

      visit '/shelters'

      expect(page).to have_link("Edit Shelter")

      click_link("Edit Shelter")

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    end

    it "I expect to see a link to delete a shelter" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')

      visit '/shelters'

      expect(page).to have_link("Delete")

      click_link("Delete")

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(shelter_1.name)
    end
  end
end
