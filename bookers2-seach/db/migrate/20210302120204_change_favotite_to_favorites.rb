class ChangeFavotiteToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_table :favotites, :favorites
  end
end
