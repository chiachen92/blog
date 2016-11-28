class Post < ApplicationRecord

  belongs_to :category
  validates :title, { length: {minimum: 3, maximum: 50}, presence: true, uniqueness: true }

  validates :body, presence: true
  has_many :comments, -> {order(created_at: :DESC)}, dependent: :destroy

  belongs_to :user

  def body_snippet
    if self.body.length > 100
      self.body[0..99]
    else
      self.body
    end
  end

  def self.search(search)
    if search.present?
      where("title || body ILIKE ?", "%#{search}%")
    end
  end
end
