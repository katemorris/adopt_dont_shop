require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the /pets path' do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      @pet = Pet.create(
        name: 'Arwen',
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        approximate_age: 2,
        sex: 'female',
        status: 'Adoptable',
        shelter_id: @shelter.id
      )
    end

    it 'I see the name of each pet and associated data' do
      visit '/pets'

      expect(page).to have_content(@pet.name)
      expect(page).to have_xpath("//img[contains(@src,'#{@pet.image}')]")
      expect(page).to have_content(@pet.approximate_age)
      expect(page).to have_content(@pet.sex)
      expect(page).to have_link(@pet.shelter.name)
    end

    it 'I can sort by adoptable or pending pets' do
      visit "/pets"

      expect(page).to have_link('See Adoptable Pets Only')
      expect(page).to have_link('See Pending Pets Only')

      click_link('See Pending Pets Only')
      expect(page).to_not have_content('Arwen')
    end

    it 'I can edit each pet in the list' do
      visit '/pets'

      expect(page).to have_link('Edit')
      click_link('Edit')

      expect(current_path).to eq("/pets/#{@pet.id}/edit")
    end

    it 'I can delete each pet in the list' do
      visit '/pets'

      expect(page).to have_link('Delete Pet')

      click_link('Delete Pet')

      expect(current_path).to eq('/pets')
      expect(page).to_not have_content('Arwen')
    end
  end
end
