class User < ApplicationRecord
  has_secure_password

  validates :name,
            presence: { message: "User cannot be created without name" },
            length: { in: 4..30, message: "Name cannot be shorther than 4 characters" }

  validates :email,
            presence: { message: "User cannot be null" },
            length: { in: 10..50, message: "Email too short or too long" },
            uniqueness: true
end
