class CreateLikedBeers < ActiveRecord::Migration[7.0]
  def change
    create_table :liked_beers do |t|
      t.string :name
      t.string :brewery
      t.float :abv
      t.integer :ibu
      t.string :variety
      t.string :img
      t.text :description
      t.timestamps
    end
  end
end
