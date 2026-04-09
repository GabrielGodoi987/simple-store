class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :short_description
      t.string :long_description
      t.integer :stock

      t.timestamps
    end
  end
end
