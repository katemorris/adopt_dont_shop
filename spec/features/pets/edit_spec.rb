require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit a Pet Show page' do
    it 'I can edit an adoptable pet' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet = Pet.create(
        image: 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/49343878/1/?bust=1602094062&width=1080',
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        status: 'adoptable',
        shelter_id: shelter.id
      )

      visit "/pets/#{pet.id}"
      expect(page).to have_link('Update Pet')
      click_on 'Update Pet'

      expect(current_path).to eq("/pets/#{pet.id}/edit")
      expect(page).to have_selector('form')

      fill_in :name, with: 'Arwen'
      fill_in :image, with: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg'
      fill_in :approximate_age, with: 2
      choose(option: 'Female')
      fill_in :description, with: 'Arwen is a sweet girl with a special gift sure to add light to any home.'
      click_button 'Update Pet'

      expect(current_path).to eq("/pets/#{pet.id}")
      expect(page).to have_content('Arwen')
      expect(page).to have_content('Age: 2')
    end
  end
end
