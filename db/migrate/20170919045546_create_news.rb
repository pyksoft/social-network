class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :message
      t.string :photo
      t.integer :likes
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
