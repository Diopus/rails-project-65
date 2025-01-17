# frozen_string_literal: true

require 'test_helper'

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength
  setup do
    @user = users(:user)
    @admin = users(:admin)

    @category = categories(:one)
    @category_not_used = categories(:not_used)

    @new_name = Faker::Commerce.department
    new_category = { name: @new_name }
    @new_category_params = { category: new_category }
  end

  test 'should get index' do
    sign_in @admin

    get admin_categories_path
    assert_response :success
  end

  test 'should get new' do
    sign_in @admin

    get new_admin_category_path
    assert_response :success
  end

  test 'should get edit' do
    sign_in @admin

    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should update category' do
    sign_in @admin
    patch admin_category_path(@category), params: @new_category_params

    @category.reload

    assert_equal @category.name, @new_name
    assert_redirected_to admin_categories_path
  end

  test 'should create category' do
    sign_in @admin
    post admin_categories_path, params: @new_category_params

    new_category = Category.find_by(name: @new_name)

    assert new_category
    assert_redirected_to admin_categories_path
  end

  test 'should destroy category' do
    sign_in @admin

    delete admin_category_path(@category_not_used)

    assert_not Category.find_by(id: @category_not_used.id)
    assert_redirected_to admin_categories_path
  end

  test 'should not destroy if category has bulletins' do
    sign_in @admin

    delete admin_category_path(@category)

    assert Category.find_by(id: @category.id)
    assert_redirected_to admin_categories_path
  end

  test 'should not get index when not logged in' do
    get admin_categories_path
    assert_redirected_to root_path
  end

  test 'should not get new when not logged in' do
    get new_admin_category_path
    assert_redirected_to root_path
  end

  test 'should not get edit when not logged in' do
    get edit_admin_category_path(@category)
    assert_redirected_to root_path
  end

  test 'should not update category when not logged in' do
    patch admin_category_path(@category), params: @new_category_params

    @category.reload

    assert_not_equal @category.name, @new_name
    assert_redirected_to root_path
  end

  test 'should not create category when not logged in' do
    post admin_categories_path, params: @new_category_params

    new_category = Category.find_by(name: @new_name)

    assert_nil new_category
    assert_redirected_to root_path
  end

  test 'should not destroy category when not logged in' do
    delete admin_category_path(@category_not_used)

    category = Category.find_by(id: @category_not_used.id)
    assert category
    assert_redirected_to root_path
  end

  test 'should not get index when user is not admin' do
    sign_in @user

    get admin_categories_path
    assert_redirected_to root_path
  end

  test 'should not get new when user is not admin' do
    sign_in @user

    get new_admin_category_path
    assert_redirected_to root_path
  end

  test 'should not get edit when user is not admin' do
    sign_in @user

    get edit_admin_category_path(@category)
    assert_redirected_to root_path
  end

  test 'should not update category when user is not admin' do
    sign_in @user

    patch admin_category_path(@category), params: @new_category_params

    @category.reload

    assert_not_equal @category.name, @new_name
    assert_redirected_to root_path
  end

  test 'should not create category when user is not admin' do
    sign_in @user

    post admin_categories_path, params: @new_category_params

    new_category = Category.find_by(name: @new_name)

    assert_nil new_category
    assert_redirected_to root_path
  end

  test 'should not destroy category when user is not admin' do
    sign_in @user

    delete admin_category_path(@category_not_used)

    category = Category.find_by(id: @category_not_used.id)
    assert category
    assert_redirected_to root_path
  end
end
