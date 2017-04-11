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
      where(created_at: from..to)
    elsif from[0] != ""
      where('created_at >= ?', from)
    elsif to[0] != ""
      where('created_at <= ?', to)
    end
  }

  scope :find_by_tag, -> tags {
    if tags.present?
      tagged_with(tags, any: true)
    end
  }

  def new
  end

end
