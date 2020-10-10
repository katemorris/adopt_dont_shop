require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit a Shelter Pets Index page' do
    it 'I can create a new adoptable pet' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      visit "/shelters/#{shelter.id}/pets"
      expect(page).to have_link('Create Pet')
      click_on 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")
      expect(page).to have_selector('form')

      fill_in :name, with: 'Arwen'
      fill_in :image, with: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg'
      fill_in :approximate_age, with: 2
      choose(option: 'Female')
      fill_in :description, with: 'Arwen is a sweet girl with a special gift sure to add light to any home.'
      click_button 'Create Pet'

      expect(current_path).to eq("/shelters/#{shelter.id}/pets")
      expect(page).to have_content('Arwen')
      expect(page).to have_content('Age: 2')
    end
  end
end
