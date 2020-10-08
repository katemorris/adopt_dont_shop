# As a visitor
# When I visit '/pets'
# Then I see each Pet in the system including the Pet's:
# - image
# - name
# - approximate age
# - sex
# - name of the shelter where the pet is currently located
require 'rails_helper'

describe "As a visitor" do
  describe "when I visit the /pets path" do
    it "I see the name of each pet and associated data" do
      pet_1 = Pet.create(
        image: "https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg",
        name: "Arwen",
        approximate_age: 2,
        sex: female,
        shelter: "Austin Pets Alive!"
      )
      pet_1 = Pet.create(
        image: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/49343878/1/?bust=1602094062&width=1080",
        name: "Nessa",
        approximate_age: 1,
        sex: female,
        shelter: "Austin Animal Shelter"
      )

      visit '/pets'

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.image}")
      expect(page).to have_content("#{pet_1.approximate_age}")
      expect(page).to have_content("#{pet_1.sex}")
      expect(page).to have_content("#{pet_1.shelter}")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_content("#{pet_2.image}")
      expect(page).to have_content("#{pet_2.approximate_age}")
      expect(page).to have_content("#{pet_2.sex}")
      expect(page).to have_content("#{pet_2.shelter}")
    end
  end
end
