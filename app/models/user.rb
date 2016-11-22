class User < ApplicationRecord

  has_many(:posts, {dependent: :nullify})
  # method that takes in two argument first one being a symbol :post, then the second being a hash with a key dependent and a value nullify
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourited_comments, through: :favourites, source: :comment
  # user has many favourited_comments meaning the user has many comments that got favourited/liked by others, how is favouriting comments done? through favourites, all these favorites/favorited comments are done on the comment model
  #  all these comments belong to the comment model
  # rails doesn't know favourited_comments so you have to tell it source
  # user has favorited many comments



  validates :email, presence: true, uniqueness: true, length: {maximum: 30}, format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password
end
