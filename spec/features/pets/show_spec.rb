require 'rails_helper'

describe 'As a visitor' do
  describe "when I visit '/pets/:id'" do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      @pet = Pet.create(
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        shelter_id: @shelter.id,
        description: 'Arwen is a sweet girl with a special gift sure to add light to any home.',
        status: 'Adoptable'
      )
    end
    it "I see the pet with that id including the pet's data" do
      visit "/pets/#{@pet.id}"

      expect(page).to have_content(@pet.name)
      expect(page).to have_xpath("//img[contains(@src,'#{@pet.image}')]")
      expect(page).to have_content(@pet.approximate_age)
      expect(page).to have_content(@pet.sex)
      expect(page).to have_content(@pet.status)
      expect(page).to have_content(@pet.description)
      expect(page).to have_link(@pet.shelter.name)
    end

    it "I can edit or delete the pet's data" do
      visit "/pets/#{@pet.id}"
      expect(page).to have_link('Delete Pet')
      expect(page).to have_link('Update Pet')
      click_link 'Delete Pet'

      expect(current_path).to eq('/pets')
      expect(page).not_to have_content(@pet.name)
    end

    it "I can edit the pet's status" do

      visit "/pets/#{@pet.id}"
      expect(page).to have_link('Change to Adoption Pending')
      expect(page).not_to have_link('Change to Adoptable')
      click_link 'Change to Adoption Pending'

      expect(current_path).to eq("/pets/#{@pet.id}")
      expect(page).to have_content('Status: Pending')

      pet_2 = Pet.create(
        image: 'https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg',
        name: 'Susie',
        approximate_age: 2,
        sex: 'female',
        shelter_id: @shelter.id,
        status: 'Pending'
      )

      visit "/pets/#{pet_2.id}"
      expect(page).not_to have_link('Change to Adoption Pending')
      expect(page).to have_link('Change to Adoptable')
      click_link 'Change to Adoptable'

      expect(current_path).to eq("/pets/#{pet_2.id}")
      expect(page).to have_content('Status: Adoptable')
    end
  end
end
