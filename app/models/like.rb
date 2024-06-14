class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id], message: "has already liked this item" }
end
