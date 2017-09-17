class AddAccountToFriend < ActiveRecord::Migration[5.1]
  def change
    add_reference :friends, :account, foreign_key: true
  end
end
