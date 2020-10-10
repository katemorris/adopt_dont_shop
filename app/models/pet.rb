class Pet < ApplicationRecord
  belongs_to :shelter

  def self.pet_count
    Pet.all.count
  end
end
