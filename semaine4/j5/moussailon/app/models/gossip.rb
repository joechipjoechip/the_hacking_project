class Gossip < ApplicationRecord
  belongs_to :mousaillon
  has_many :comments
end
