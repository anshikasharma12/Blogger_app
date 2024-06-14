class User < ApplicationRecord
  # validates :name, presence: true
  has_many :posts,    dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def admin?
    admin
  end
end
