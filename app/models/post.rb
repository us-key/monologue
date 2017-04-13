class Post < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :labels
  acts_as_taggable
  default_scope -> {order(created_at: :desc)}
  validates :content, length: { maximum: 100},
                      presence: true
  validates :user_id, presence: true

  scope :created_between, -> from, to {
    if from[0] != "" && to[0] != ""
      where(created_at: from[0]..(to[0] + ' 23:59:59'))
    elsif from[0] != ""
      where('created_at >= ?', from[0])
    elsif to[0] != ""
      where('created_at <= ?', (to[0] + ' 23:59:59'))
    end
  }

  scope :find_by_tag, -> tags {
    if tags.present?
      tagged_with(tags, any: true)
    end
  }

  scope :content_like, -> content {
    where('content like ?', "%#{content}%") if content.present?
  }

  def new
  end

end
