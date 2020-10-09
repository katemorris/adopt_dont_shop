# User Story 10, Shelter Pet Creation
#
# As a visitor
# When I visit a Shelter Pets Index page
# Then I see a link to add a new adoptable pet for that shelter "Create Pet"
# When I click the link
# I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
# When I fill in the form with the pet's:
# - image
# - name
# - description
# - approximate age
# - sex ('female' or 'male')
# And I click the button "Create Pet"
# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
# and I am redirected to the Shelter Pets Index page where I can see the new pet listed
require 'rails_helper'

describe "As a visitor" do
  shelter_1 = Shelter.create(name: 'Austin Pets Alive!', address: '123 Happy Ln', city: 'Austin', state: 'TX', zip:'78704')
  describe "when I visit a Shelter Pets Index page" do
    it "I see a link to add a new adoptable pet for that shelter Create Pet" do
      visit "/shelters/#{shelter_1.id}/pets"
      expect(page).to have_link("Create Pet")
    end
  end
  describe "When I click the link" do
    it "I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet" do
      visit "/shelters/#{shelter_1.id}/pets"
      click_on "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")
      expect(page).to have_selector("form")
    end
  end
  describe "When I fill in the form with the pet's data" do
    it "I click the button to create an adoptable pet" do
      visit "/shelters/#{shelter_1.id}/pets/new"

      fill_in :name, with: "Arwen"
      fill_in :image, with: "https://www.dogmal.com/wp-content/uploads/2017/04/corgi-husky-mix-cost.jpg"
      fill_in :approximate_age, with: 2
      choose(option: "Female")
      fill_in :description, with: "Arwen is a sweet girl with a special gift sure to add light to any home."
      click_button "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
      expect(page).to have_content("Arwen")
      expect(page).to have_content("Age: 2")
    end
  end
end
