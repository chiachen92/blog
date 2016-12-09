class Post < ApplicationRecord

  belongs_to :category

  has_many :comments, -> {order(created_at: :DESC)}, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false, message: 'must be unique' }
  validates :body, length: { minimum: 5 }

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
