class AddProfileToAccount < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :profile, foreign_key: true
  end
end
