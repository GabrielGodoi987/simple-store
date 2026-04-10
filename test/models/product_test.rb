require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "Should create a product with valid attributes" do
    product = Product.new(
      name: "Product valid test",
      price: 27.87,
      short_description: "short description",
      long_description: "long product description",
      stock: 5
    )
    assert product.save
  end

  test "Should not create a product with name nil" do
    product = Product.new(
      name: nil,
      price: 27.87,
      short_description: "short description",
      long_description: "long product description",
      stock: 2
    )
    assert_not product.save, "Name cannot be null"
  end

  test "Should not create a product with price nil" do
    product = Product.new(
      name: "Product with nil price",
      price: nil,
      short_description: "short description",
      long_description: "long product description",
      stock: 2
    )
    assert_not product.save, "Price cannot be null"
  end

  test "Should not create a product with negative price" do
    product = Product.new(
      name: "Product negative price",
      price: -100,
      short_description: "short description",
      long_description: "long product description",
      stock: 2
    )
    assert_not product.save, "Cannot create a product with negative price"
  end

  test "Should not create a product with zero price" do
    product = Product.new(
      name: "Product zero price",
      price: 0,
      short_description: "short description",
      long_description: "long product description",
      stock: 2
    )
    assert_not product.save, "Cannot create a product with zero price"
  end

  test "Should not create a product without name" do
    product = Product.new
    assert_not product.save, false
  end
end
