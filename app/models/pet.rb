class Pet < ApplicationRecord
  belongs_to :shelter

  def self.pet_count
    Pet.all.count
  end

  def self.adoptable_first
    Pet.order(:status)
  end
end
