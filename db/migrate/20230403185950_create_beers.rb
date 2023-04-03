class CreateBeers < ActiveRecord::Migration[7.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewery
      t.float :abv
      t.integer :ibu
      t.string :primary_flavor
      t.string :secondary_flavor
      t.string :color
      t.string :variety

      t.timestamps
    end
  end
end
