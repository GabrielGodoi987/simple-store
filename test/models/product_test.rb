require "test_helper"

class ProductTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

  test "Should create a product with price" do
    product = Product.new(name: "Product new test", price: 27.87, short_description: "short description", long_description: "long product description", stock: 5)
    puts product.errors.full_messages
    assert product.save
  end

  test "Should not create a product with name or price nil" do
   product1 = Product.new(name: nil, price: 27.87, short_description: "short description", long_description: "long product description", stock: 2)
   product2 = Product.new(name: "Product test", price: nil, short_description: "short description", long_description: "long product description", stock: 2)

   assert_not product1.save, "Name cannot be null"
   assert_not product2.save, "Price cannot be null"
  end


  test "Should not create a product with zero or negative price" do
    product = Product.new(name: "New product", price: -100, short_description: "short description", long_description: "long product description", stock: 2)
    product1 = Product.new(name: "New product", price: 0, short_description: "short description", long_description: "long product description", stock: 2)

    assert_not product.save, "Cannot create a product with zero or negative price"
    assert_not product1.save, "Cannot create a product with zero or negative price"
  end

  test "Should not create a product without name" do
    product = Product.new
    assert_not product.save, false
  end
end
