class Product < ApplicationRecord
   validates :price,
            presence: { message: "Price cannot be null" },
            numericality: { greater_than: 0, message: "Cannot create a product with zero or negative price" }

  validates :name,
            presence: { message: "Name cannot be null" },
            uniqueness: { message: "Name already exists" },
            length: { in: 3..40, message: "Name have to contain at least 3 characters" }
end
