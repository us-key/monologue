class Post < ApplicationRecord
  belongs_to :user
  has_many :tags
  default_scope -> {order(created_at: :desc)}
  validates :content, length: { maximum: 100},
                      presence: true
  validates :user_id, presence: true

  def new
  end
end
