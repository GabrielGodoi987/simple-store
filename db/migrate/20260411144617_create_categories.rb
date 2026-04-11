class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.boolean :is_active

      t.timestamps
    end
  end
end
