class AddUserReferencesToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :user, foreign_key: true
    #  first argument is the table i'm adding to and :user is the column i'm adding
  end
end
