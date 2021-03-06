require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the /shelters/:id path' do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
    end
    it 'I see a shelter with that ID and data' do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content(@shelter.name)
      expect(page).to have_content(@shelter.address)
      expect(page).to have_content(@shelter.city)
      expect(page).to have_content(@shelter.state)
      expect(page).to have_content(@shelter.zip)
    end

    it 'I see a link to view pets' do
      visit "/shelters/#{@shelter.id}"
      expect(page).to have_link('View Pets')
      click_link('View Pets')

      expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    end

    it 'I see a link to edit the shelter' do
      visit "/shelters/#{@shelter.id}"
      expect(page).to have_link('Update Shelter')
      click_link('Update Shelter')

      expect(current_path).to eq("/shelters/#{@shelter.id}/edit")
    end

    it 'I see a link to delete the shelter' do
      shelter_2 = Shelter.create(
        name: 'City of Austin Animal Shelter',
        address: '453 City St',
        city: 'Austin',
        state: 'TX',
        zip: '78754'
      )

      visit "/shelters/#{@shelter.id}"
      click_link 'Delete Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).not_to have_content(@shelter.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end
