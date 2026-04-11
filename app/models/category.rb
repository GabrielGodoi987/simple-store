class Category < ApplicationRecord
  validates :name,
            presence: { message: "Category name cannot be null" },
            length: { in: 3..10, message: "Name must contain at leas 3 characters" }

  validates :slug,
            presence: { message: "Slug cannot be null" },
            uniqueness: { message: "Slug already exists" },
            length: { in: 3..20, message: "Slug must contain at least 3 characters" },
            format: { with: /\A[a-z0-9-]+\z/, message: "Slug must contain only lowercase letters, numbers, and hyphens" }
end
