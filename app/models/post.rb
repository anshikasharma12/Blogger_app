class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, as: :likeable, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
end
