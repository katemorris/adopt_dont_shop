require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the /pets path' do
    it 'I see the name of each pet and associated data' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet_1 = Pet.create(
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        shelter_id: shelter.id
      )
      pet_2 = Pet.create(
        image: 'https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/49343878/1/?bust=1602094062&width=1080',
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        shelter_id: shelter.id
      )

      visit '/pets'

      expect(page).to have_content(pet_1.name)
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
      expect(page).to have_content(pet_1.approximate_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_link(pet_1.shelter.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_xpath("//img[contains(@src,'#{pet_2.image}')]")
      expect(page).to have_content(pet_2.approximate_age)
      expect(page).to have_content(pet_2.sex)
      expect(page).to have_link(pet_2.shelter.name)
    end

    it 'I can edit each pet in the list' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet = Pet.create(
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        shelter_id: shelter.id
      )

      visit '/pets'

      expect(page).to have_link('Edit')

      click_link('Edit')

      expect(current_path).to eq("/pets/#{pet.id}/edit")
    end

    it 'I can delete each pet in the list' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet = Pet.create(
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        shelter_id: shelter.id
      )

      visit '/pets'

      expect(page).to have_link('Delete Pet')

      click_link('Delete Pet')

      expect(current_path).to eq('/pets')
      expect(page).to_not have_content('Arwen')
    end
  end
end
