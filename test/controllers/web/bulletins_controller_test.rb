# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin_draft = bulletins(:draft)
    @bulletin_published = bulletins(:published)

    @bulletin_archived = bulletins(:archived)
    @bulletin_rejected = bulletins(:rejected)
    @bulletin_under_moderation = bulletins(:under_moderation)

    @bulletin_default_other = bulletins(:draft_other)

    @bulletin_published_other = bulletins(:published_other)

    @user = users(:user)
    @other_user = users(:other_user)
    @admin = users(:admin)

    @category = categories(:one)

    @image = fixture_file_upload('test.jpg', 'image/jpg')
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin_published)
    assert_response :success
  end

  test 'should get new when logged in' do
    sign_in @user

    get new_bulletin_path
    assert_response :success
  end

  test 'should not get new when not logged in' do
    get new_bulletin_path
    assert_redirected_to root_path
  end

  test 'should create bulletin' do
    sign_in @user

    title_length = rand(Bulletin.title_max_length)
    new_bulletin = {
      title: Faker::Lorem.paragraph_by_chars(number: title_length),
      description: Faker::Lorem.paragraph_by_chars,
      category_id: @category.id,
      image: @image
    }
    bulletin_params = { bulletin: new_bulletin }

    post bulletins_path, params: bulletin_params

    bulletin = Bulletin.find_by(title: new_bulletin[:title])

    assert_redirected_to bulletin_path(bulletin)
  end

  test 'should get edit when author logged in' do
    sign_in @user

    get edit_bulletin_url(@bulletin_draft)
    assert_response :success
  end

  test 'should not get edit when author not logged in' do
    get edit_bulletin_url(@bulletin_draft)
    assert_redirected_to root_path
  end

  test 'should update bulletin when author logged in' do
    sign_in @user

    title_length = rand(Bulletin.title_max_length)
    new_title = Faker::Lorem.paragraph_by_chars(number: title_length)

    patch bulletin_url(@bulletin_draft), params: { bulletin: { title: new_title } }

    @bulletin_draft.reload

    assert_equal @bulletin_draft.title, new_title
    assert_redirected_to profile_path
  end

  test 'should not update bulletin when author not logged in' do
    title_length = rand(Bulletin.title_max_length)
    new_title = Faker::Lorem.paragraph_by_chars(number: title_length)

    patch bulletin_url(@bulletin_draft), params: { bulletin: { title: new_title } }

    @bulletin_draft.reload

    assert_not_equal @bulletin_draft.title, new_title
    assert_redirected_to root_path
  end
end
