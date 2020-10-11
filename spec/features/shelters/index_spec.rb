require 'rails_helper'

describe "As a visitor" do
  describe "when the visitor visits the /shelters path" do
    it "the visitor sees the name of each shelter" do
      shelter_1 = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      shelter_2 = Shelter.create(
        name: 'City of Austin Animal Shelter',
        address: '453 City St',
        city: 'Austin',
        state: 'TX',
        zip: '78754'
      )

      visit '/shelters'

      expect(page).to have_link(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end

    it "I expect to see a link to the edit page of a shelter" do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )

      visit '/shelters'

      expect(page).to have_link('Edit Shelter')

      click_link('Edit Shelter')

      expect(current_path).to eq("/shelters/#{shelter.id}/edit")
    end

    it "I expect to see a link to delete a shelter" do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )

      visit '/shelters'

      expect(page).to have_link('Delete')

      click_link('Delete')

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(shelter.name)
    end

    it 'I expect to be able to sort by number of pets or alphabetically' do
      shelter_1 = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      Pet.create(name: 'Bubbly', shelter_id: shelter_1.id)
      Pet.create(name: 'Garfield', shelter_id: shelter_1.id)
      Pet.create(name: 'Square', shelter_id: shelter_1.id)
      Pet.create(name: 'Sugar', shelter_id: shelter_1.id)

      shelter_2 = Shelter.create(
        name: 'City of Austin Animal Shelter',
        address: '453 City St',
        city: 'Austin',
        state: 'TX',
        zip: '78754'
      )
      Pet.create(name: 'Horace', shelter_id: shelter_2.id)

      shelter_3 = Shelter.create(
        name: 'Seattle Animal Shelter',
        address: '2061 15th Ave W',
        city: 'Seattle',
        state: 'WA',
        zip: '98119'
      )
      Pet.create(name: 'BunBun', shelter_id: shelter_3.id)
      Pet.create(name: 'Mishka', shelter_id: shelter_3.id)

      shelter_4 = Shelter.create(
        name: 'Dumb Friends League',
        address: '2080 Quebec St',
        city: 'Denver',
        state: 'CO',
        zip: '80222'
      )
      Pet.create(name: 'Tama', shelter_id: shelter_4.id)
      Pet.create(name: 'Gunner', shelter_id: shelter_4.id)
      Pet.create(name: 'Black', shelter_id: shelter_4.id)

      visit '/shelters'

      expect(page).to have_link('Sort by # Pets')
      click_link('Sort by # Pets')
      first_name = find('.li', match: :first)
      expect(first_name).to have_content(shelter_1.name)

      visit '/shelters'
      expect(page).to have_link('Sort Alphabetically')
      click_link('Sort Alphabetically')
      alpha_last_name = find('.li', match: :last)
      expect(alpha_last_name).to have_content(shelter_3.name)
    end
  end
end
