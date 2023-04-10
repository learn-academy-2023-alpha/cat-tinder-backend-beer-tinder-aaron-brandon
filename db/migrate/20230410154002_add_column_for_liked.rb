class AddColumnForLiked < ActiveRecord::Migration[7.0]
  def change
    add_column :beers, :liked, :Bool
  end
end
