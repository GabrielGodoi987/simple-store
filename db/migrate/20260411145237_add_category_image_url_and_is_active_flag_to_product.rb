class AddCategoryImageUrlAndIsActiveFlagToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :image_url, :string
    add_reference :products, :category, null: false, foreign_key: true
  end
end
