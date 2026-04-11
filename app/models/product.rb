class Product < ApplicationRecord
  attribute :is_active, :boolean, default: true

  validates :price,
            presence: { message: "Price cannot be null" },
            numericality: { greater_than: 0, message: "Cannot create a product with zero or negative price" }

  validates :name,
            presence: { message: "Name cannot be null" },
            uniqueness: { message: "Name already exists" },
            length: { in: 3..40, message: "Name have to contain at least 3 characters" }

  validates :category_id,
             presence: { message: "Product needs to be related to a category" }


  belongs_to :category, class_name: "Category", foreign_key: "category_id"
end
