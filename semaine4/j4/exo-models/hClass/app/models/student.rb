class Student < ApplicationRecord
  belongs_to :teach

  # validates :name, 
  #   presence: true,
  #   length: {maximum: 50},
  #   uniqueness: {case_sensitive: false}

  # validates :age, 
  #   presence: true,
  #   length: {maximum: 2}

  # validates :bio, 
  #   length: {maximum: 450}
end
