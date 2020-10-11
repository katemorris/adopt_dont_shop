class Pet < ApplicationRecord
  belongs_to :shelter

  def self.pet_count
    Pet.all.count
  end

  def self.adoptable_first
    Pet.order(:status)
  end

  def self.adoptable_filter
    Pet.all.select do |pet|
      pet.status.downcase == 'adoptable'
    end
  end

  def self.pending_filter
    Pet.all.select do |pet|
      pet.status.downcase == 'pending'
    end
  end
end
