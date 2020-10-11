require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
  end
  describe 'instance methods' do
    it '.pet_count' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet_1 = Pet.create(
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        shelter_id: shelter.id
      )
      pet_2 = Pet.create(
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        shelter_id: shelter.id
      )
      pet_3 = Pet.create(
        name: 'Longhair',
        approximate_age: 1,
        sex: 'male',
        shelter_id: shelter.id
      )

      expect(shelter.pets.pet_count).to eq(3)
    end

    it '.adoptable_first' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet_1 = Pet.create(
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        status: 'Adoptable',
        shelter_id: shelter.id
      )
      pet_2 = Pet.create(
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        status: 'Pending',
        shelter_id: shelter.id
      )
      pet_3 = Pet.create(
        name: 'Longhair',
        approximate_age: 1,
        sex: 'male',
        status: 'Adoptable',
        shelter_id: shelter.id
      )

      expect(shelter.pets.adoptable_first).to eq([pet_1, pet_3, pet_2])
      expect(shelter.pets.adoptable_first).to_not eq([pet_1, pet_2, pet_3])
    end

    it '.adoptable_filter' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet_1 = Pet.create(
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        status: 'Adoptable',
        shelter_id: shelter.id
      )
      pet_2 = Pet.create(
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        status: 'Pending',
        shelter_id: shelter.id
      )
      pet_3 = Pet.create(
        name: 'Longhair',
        approximate_age: 1,
        sex: 'male',
        status: 'Adoptable',
        shelter_id: shelter.id
      )

      expect(shelter.pets.adoptable_filter).to eq([pet_1, pet_3])
      expect(shelter.pets.adoptable_filter).to_not eq([pet_1, pet_2, pet_3])
    end

    it '.pending_filter' do
      shelter = Shelter.create(
        name: 'Austin Pets Alive!',
        address: '123 Happy Ln',
        city: 'Austin',
        state: 'TX',
        zip: '78704'
      )
      pet_1 = Pet.create(
        name: 'Arwen',
        approximate_age: 2,
        sex: 'female',
        status: 'Adoptable',
        shelter_id: shelter.id
      )
      pet_2 = Pet.create(
        name: 'Nessa',
        approximate_age: 1,
        sex: 'female',
        status: 'Pending',
        shelter_id: shelter.id
      )
      pet_3 = Pet.create(
        name: 'Longhair',
        approximate_age: 1,
        sex: 'male',
        status: 'Adoptable',
        shelter_id: shelter.id
      )

      expect(shelter.pets.pending_filter).to eq([pet_2])
      expect(shelter.pets.pending_filter).to_not eq([pet_1, pet_2, pet_3])
    end
  end
end
