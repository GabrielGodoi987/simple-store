require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "Should create a category with valid attributes" do
    category = Category.new(
      name: "ABC",
      slug: "abc",
      is_active: true
    )
    assert category.save
  end

  test "Should not be able to create a category without name" do
    category = Category.new
    assert_not category.save, "Category name cannot be null"
  end

  test "Should not create a category with name too short" do
    category = Category.new(
      name: "AB",
      slug: "ab",
      is_active: true
    )
    assert_not category.save, "Name must contain at least 3 characters"
  end

  test "Should not create a category with name too long" do
    category = Category.new(
      name: "A" * 11,
      slug: "long-name",
      is_active: true
    )
    assert_not category.save, "Name must contain at most 10 characters"
  end

  test "Should not be able to create a category without slug" do
    category = Category.new(
      name: "Test",
      slug: nil,
      is_active: true
    )
    assert_not category.save, "Slug cannot be null"
  end

  test "Should not create a category with slug too short" do
    category = Category.new(
      name: "Test",
      slug: "ab",
      is_active: true
    )
    assert_not category.save, "Slug must contain at least 3 characters"
  end

  test "Should not create a category with slug too long" do
    category = Category.new(
      name: "Test",
      slug: "a" * 21,
      is_active: true
    )
    assert_not category.save, "Slug must contain at most 20 characters"
  end

  test "Should not create a category with duplicate slug" do
    Category.create!(
      name: "Test1",
      slug: "test-slug",
      is_active: true
    )

    category = Category.new(
      name: "Test2",
      slug: "test-slug",
      is_active: true
    )
    assert_not category.save, "Slug already exists"
  end

  test "Should not create a category with invalid slug format" do
    category = Category.new(
      name: "Test",
      slug: "Invalid Slug!",
      is_active: true
    )
    assert_not category.save, "Slug must contain only lowercase letters, numbers, and hyphens"
  end

  test "Should create a category with valid slug containing hyphens and numbers" do
    category = Category.new(
      name: "Test",
      slug: "test-123-category",
      is_active: true
    )
    assert category.save
  end
end
