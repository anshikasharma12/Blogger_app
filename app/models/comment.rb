class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  default_scope -> { order(id: :desc) }
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to  :parent, class_name: 'Comment', optional: true
  has_many    :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  validates :body, presence: :true

end
