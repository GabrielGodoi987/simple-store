class AddDefaultFalseToIsActiveInProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :is_active, :boolean, default: true
  end
end
