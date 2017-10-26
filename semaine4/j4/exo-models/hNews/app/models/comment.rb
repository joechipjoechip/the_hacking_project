class Comment < ApplicationRecord
  belongs_to :link || :comment
  has_many :comments
end
