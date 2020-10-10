require 'rails_helper'

describe 'As a visitor' do
  describe "when I visit '/pets/:id'" do
    it "I see the pet with that id including the pet's data" do
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
        shelter_id: shelter.id,
        description: 'Arwen is a sweet girl with a special gift sure to add light to any home.',
        status: 'Adoptable'
      )

      visit "/pets/#{pet.id}"

      expect(page).to have_content(pet.name)
      expect(page).to have_xpath("//img[contains(@src,'#{pet.image}')]")
      expect(page).to have_content(pet.approximate_age)
      expect(page).to have_content(pet.sex)
      expect(page).to have_content(pet.status)
      expect(page).to have_content(pet.description)
      expect(page).to have_link(pet.shelter.name)
    end

    it "I can delete the pet's data" do
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
        shelter_id: shelter.id,
        description: 'Arwen is a sweet girl with a special gift sure to add light to any home.',
        status: 'Adoptable'
      )

      visit "/pets/#{pet.id}"
      expect(page).to have_link('Delete Pet')
      click_link 'Delete Pet'

      expect(current_path).to eq('/pets')
      expect(page).not_to have_content(pet.name)

    end
  end
end
