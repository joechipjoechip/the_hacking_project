class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :email, 
    presence: true,
    uniqueness: { case_sensitive: false},
    length: {maximum: 250},
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
