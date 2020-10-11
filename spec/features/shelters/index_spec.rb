require 'rails_helper'

describe "As a visitor" do
  describe "when the visitor visits the /shelters path" do
    before(:each) do
      @shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
    end
    it "the visitor sees the name of each shelter" do
      visit '/shelters'

      expect(page).to have_link(@shelter.name)
    end

    it "I expect to see a link to the edit page of a shelter" do
      visit '/shelters'

      expect(page).to have_link('Edit Shelter')
      click_link('Edit Shelter')

      expect(current_path).to eq("/shelters/#{@shelter.id}/edit")
    end

    it "I expect to see a link to delete a shelter" do
      visit '/shelters'

      expect(page).to have_link('Delete')
      click_link('Delete')

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content(@shelter.name)
    end

    it 'I expect to be able to sort by number of pets or alphabetically' do
      visit '/shelters'

      expect(page).to have_link('Sort by # Pets')
      click_link('Sort by # Pets')
      expect(current_path).to eq('/shelters')
      expect(page).to have_link('Sort Alphabetically')
      click_link('Sort Alphabetically')
      expect(current_path).to eq('/shelters')
    end
  end
end
