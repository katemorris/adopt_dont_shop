require 'rails_helper'

describe 'As a visitor' do
  describe "I visit '/shelters/:shelter_id/pets'" do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      @pet = Pet.create(
        name: 'Longhair',
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        approximate_age: 1,
        sex: 'male',
        status: 'Adoptable',
        shelter_id: @shelter.id
      )
    end
    it 'I see all pets, their data, and a count of pets at the shelter' do
      visit "/shelters/#{@shelter.id}/pets"

      expect(page).to have_content('Pets: 1')
      expect(page).to have_content(@pet.name)
      expect(page).to have_link(@pet.name)
      expect(page).to have_xpath("//img[contains(@src,'#{@pet.image}')]")
      expect(page).to have_content(@pet.approximate_age)
      expect(page).to have_content(@pet.sex)
    end

    it 'I can sort by adoptable or pending pets' do
      visit "/shelters/#{@shelter.id}/pets"

      expect(page).to have_link('See Adoptable Pets Only')
      expect(page).to have_link('See Pending Pets Only')

      click_link('See Pending Pets Only')
      expect(page).to_not have_content('Longhair')
    end

    it 'I can edit each pet in the list' do
      visit "/shelters/#{@shelter.id}/pets"
      expect(page).to have_link('Edit')
      click_link('Edit')
      expect(current_path).to eq("/pets/#{@pet.id}/edit")
    end

    it 'I can delete each pet in the list' do
      visit "/shelters/#{@shelter.id}/pets"
      expect(page).to have_link('Delete Pet')
      click_link('Delete Pet')
      expect(current_path).to eq('/pets')
    end
  end
end
