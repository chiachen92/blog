class Comment < ApplicationRecord
  validates :body, presence: true, uniqueness: true

  belongs_to :post
  belongs_to :user

  has_many :favourites, {:dependent => :destroy}

  def favourite_of(someone)
    favourites.find_by_user_id(someone)
  end

  def favourited_by?(someone)
    favourite_of(someone).present?
  end
  # how to put this in application controller
end
