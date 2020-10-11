require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit a shelter show page' do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
    end

    it 'I see a link to update the shelter' do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link('Update Shelter')
    end

    it 'when the Update Shelter link is clicked, I go to the shelter page and see a form' do
      visit "/shelters/#{@shelter.id}"
      click_on 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter.id}/edit")
      expect(page).to have_selector('form')
    end

    it 'I fill out the form and see the new shelter on /shelters' do
      visit "/shelters/#{@shelter.id}/edit"

      fill_in :name, with: 'Dumb Friends League'
      fill_in :address, with: '9903 Faithful Rd'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80382'
      click_button 'Update Shelter'

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to have_content('Dumb Friends League')
    end
  end
end
