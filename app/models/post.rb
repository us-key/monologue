class Post < ApplicationRecord
  belongs_to :user
  has_many :tags
  validates :content, length: { maximum: 100}, 
                      presence: ture
end
