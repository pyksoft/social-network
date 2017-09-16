class AddAccountToProfile < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :account, foreign_key: true
  end
end
