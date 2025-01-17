# frozen_string_literal: true

require 'test_helper'

class Admin::DashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test 'should get dashboards index (under moderation)' do
    sign_in @admin

    get admin_root_path
    assert_response :success
  end

  test 'should not get dashboards index (under moderation) if not admin' do
    get admin_root_path
    assert_redirected_to root_path
  end

  test 'should not get dashboards index (under moderation) if not logged in' do
    sign_in @user

    get admin_root_path
    assert_redirected_to root_path
  end
end
