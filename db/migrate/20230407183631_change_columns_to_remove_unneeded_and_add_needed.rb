class ChangeColumnsToRemoveUnneededAndAddNeeded < ActiveRecord::Migration[7.0]
  def change
    remove_column :beers, :primary_flavor
    remove_column :beers, :secondary_flavor
    remove_column :beers, :color
    add_column :beers, :description, :text
    add_column :beers, :img, :string
  end
end