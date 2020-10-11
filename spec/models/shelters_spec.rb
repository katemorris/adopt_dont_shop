require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end
  describe 'instance methods' do
    it '.sort_by_pets' do
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

      shelter_order = [shelter_1, shelter_4, shelter_3, shelter_2]
      expect(Shelter.all.sort_by_pets).to eq(shelter_order)
    end

    it '.sort_by_pets' do
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

      shelter_order = [shelter_1, shelter_2, shelter_4, shelter_3]
      expect(Shelter.all.sort_alpha).to eq(shelter_order)
    end
  end
end
