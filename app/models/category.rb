class Category < ApplicationRecord
  validates :title, presence: true

  has_many :posts, dependent: :nullify
  # If you have set the dependent option to nullify it will keep all the answers whose question_id is the id of the question you just deleted (answers associated with that question) but it will update their question_id to become NULL. 
end
