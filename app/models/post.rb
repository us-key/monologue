class Post < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :labels
  acts_as_taggable
  default_scope -> {order(created_at: :desc)}
  validates :content, length: { maximum: 100},
                      presence: true
  validates :user_id, presence: true

  def new
  end

end
