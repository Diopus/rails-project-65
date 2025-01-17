# frozen_string_literal: true

require 'test_helper'

class Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:user)

    @bulletin_under_moderation = bulletins(:under_moderation)
    @bulletin_published = bulletins(:published)
    @bulletin_rejected = bulletins(:rejected)
    @bulletin_archived = bulletins(:archived)
  end

  test 'should get all bulletin index' do
    sign_in @admin

    get admin_bulletins_path
    assert_response :success
  end

  test 'should not get bulletin index if not admin' do
    get admin_bulletins_path
    assert_redirected_to root_path
  end

  test 'should not get bulletin index if not logged in' do
    sign_in @user

    get admin_bulletins_path
    assert_redirected_to root_path
  end

  test 'should set state published' do
    sign_in @admin
    patch publish_admin_bulletin_url(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.published?
    assert_redirected_to admin_root_path
  end

  test 'should not set state published if not admin' do
    sign_in @user
    patch publish_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end

  test 'should not set state published if not logged in' do
    patch publish_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end

  test 'should set state rejected' do
    sign_in @admin
    patch reject_admin_bulletin_url(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.rejected?
    assert_redirected_to admin_root_path
  end

  test 'should not set state rejected if not admin' do
    sign_in @user
    patch reject_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end

  test 'should not set state rejected if not logged in' do
    patch reject_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end

  test 'should set state archived' do
    sign_in @admin
    patch archive_admin_bulletin_url(@bulletin_under_moderation)

    @bulletin_under_moderation.reload
    assert @bulletin_under_moderation.archived?
    assert_redirected_to admin_root_path
  end

  test 'should not set state archived if not admin' do
    sign_in @user
    patch archive_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end

  test 'should not set state archived if not logged in' do
    patch archive_admin_bulletin_path(@bulletin_under_moderation)

    @bulletin_under_moderation.reload

    assert @bulletin_under_moderation.under_moderation?
    assert_redirected_to root_path
  end
end
