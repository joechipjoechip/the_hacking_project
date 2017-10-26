class Teach < ApplicationRecord
  has_many :students

  validates :title, 
    presence: true,
    length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  validates :description, 
    presence: true,
    length: {maximum: 450}

end
