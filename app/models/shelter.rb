class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy

  def self.sort_by_pets
    Shelter.all.sort_by do |shelter|
      shelter.pets.pet_count
    end.reverse
  end

  def self.sort_alpha
    Shelter.order(:name)
  end
end
