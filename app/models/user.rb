class User < ApplicationRecord
  has_many :posts
  validates :name, presence: true
            :email, presence: true
end
