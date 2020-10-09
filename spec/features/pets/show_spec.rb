require 'rails_helper'

describe "As a visitor" do
  describe "when I visit '/pets/:id'" do
    it "I see the pet with that id including the pet's data" do
      shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
      pet_1 = Pet.create(
        image: "https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg",
        name: "Arwen",
        approximate_age: 2,
        sex: "female",
        shelter_id: shelter_1.id,
        description: "Arwen is a sweet girl with a special gift sure to add light to any home.",
        status: "Adoptable"
      )

      visit "/pets/#{pet_1.id}"

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_xpath("//img[contains(@src,'#{pet_1.image}')]")
      expect(page).to have_content("#{pet_1.approximate_age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.status}")
      expect(page).to have_content("#{pet_1.description}")
      expect(page).to have_content("#{pet_1.shelter.name}")
    end
  end
end
