require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: "Test", slug: "test", is_active: true)
    @product = products(:one)
  end

  teardown do
    Product.where(category_id: @category.id).destroy_all if @category&.persisted?
    @category.destroy! if @category&.persisted?
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { long_description: "desc", name: "New Product", price: 10.0, short_description: "short", stock: 5, category_id: @category.id } }, as: :json
    end

    assert_response :created
  end

  test "should show product" do
    @product.update!(category_id: @category.id)
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should update product" do
    @product.update!(category_id: @category.id)
    patch product_url(@product), params: { product: { long_description: "updated", name: "Updated Name", price: 15.0, short_description: "updated short", stock: 10, category_id: @category.id } }, as: :json
    assert_response :success
  end

  test "should destroy product" do
    @product.update!(category_id: @category.id)
    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end

    assert_response :no_content
  end
end
