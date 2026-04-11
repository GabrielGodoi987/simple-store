require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @category = Category.create!(name: "Cat", slug: "cat", is_active: true)
  end

  teardown do
    Product.where(category_id: @category.id).destroy_all if @category&.persisted?
    @category.destroy! if @category&.persisted?
  end

  test "Should create a product with valid attributes" do
    product = Product.new(
      name: "Product valid test",
      price: 27.87,
      short_description: "short description",
      long_description: "long product description",
      stock: 5,
      category_id: @category.id
    )
    assert product.save
  end

  test "Should not create a product with name nil" do
    product = Product.new(
      name: nil,
      price: 27.87,
      short_description: "short description",
      long_description: "long product description",
      stock: 2,
      category_id: @category.id
    )
    assert_not product.save, "Name cannot be null"
  end

  test "Should not create a product with price nil" do
    product = Product.new(
      name: "Product with nil price",
      price: nil,
      short_description: "short description",
      long_description: "long product description",
      stock: 2,
      category_id: @category.id
    )
    assert_not product.save, "Price cannot be null"
  end

  test "Should not create a product with negative price" do
    product = Product.new(
      name: "Product negative price",
      price: -100,
      short_description: "short description",
      long_description: "long product description",
      stock: 2,
      category_id: @category.id
    )
    assert_not product.save, "Cannot create a product with negative price"
  end

  test "Should not create a product with zero price" do
    product = Product.new(
      name: "Product zero price",
      price: 0,
      short_description: "short description",
      long_description: "long product description",
      stock: 2,
      category_id: @category.id
    )
    assert_not product.save, "Cannot create a product with zero price"
  end

  test "Should not create a product without name" do
    product = Product.new(category_id: @category.id)
    assert_not product.save, false
  end

  test "Should not create a product without category" do
    product = Product.new(
      name: "Product without category",
      price: 27.87,
      short_description: "short description",
      long_description: "long product description",
      stock: 2
    )
    assert_not product.save, "Product needs to be related to a category"
  end

  test "Should not create a product with duplicate name" do
    Product.create!(
      name: "Duplicate Name",
      price: 10.0,
      short_description: "desc",
      long_description: "long desc",
      stock: 1,
      category_id: @category.id
    )

    product = Product.new(
      name: "Duplicate Name",
      price: 15.0,
      short_description: "another desc",
      long_description: "another long desc",
      stock: 2,
      category_id: @category.id
    )
    assert_not product.save, "Name already exists"
  end
end
