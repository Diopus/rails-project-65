# frozen_string_literal: true

require 'application_system_test_case'

class BulletinsTest < ApplicationSystemTestCase
  setup do
    @bulletin_draft = bulletins(:draft)
    @bulletin_published = bulletins(:published)
    @bulletin_under_moderation = bulletins(:under_moderation)

    @category = categories(:one)

    @user = users(:user)
    @admin = users(:admin)

    @image_name = 'test.jpg'

    title_length = rand(Bulletin.title_max_length)
    @new_title = Faker::Lorem.paragraph_by_chars(number: title_length)
    @new_description = Faker::Lorem.paragraph_by_chars
  end

  test 'visiting the index' do
    sign_in @user

    visit root_path
    assert_selector 'h2', text: I18n.t('bulletins.titles.all')
    assert_text @bulletin_published.title
  end

  test 'should create bulletin' do
    sign_in @user

    # try from navigation button
    click_on I18n.t('layouts.nav.new_bulletin')
    assert_selector 'h2', text: I18n.t('bulletins.titles.new')

    # try from My bulletins page button
    click_on I18n.t('layouts.nav.my_bulletins')
    assert_selector 'h2', text: I18n.t('bulletins.titles.my')

    find('.my-bulletins-new-button').click
    assert_selector 'h2', text: I18n.t('bulletins.titles.new')

    fill_in 'bulletin_title', with: @new_title
    fill_in 'bulletin_description', with: @new_description
    select @category.name, from: 'bulletin_category_id'

    file_input = find('input[type="file"]', visible: false)
    file_input.attach_file(fixture_file_path(@image_name))

    find('input[type="submit"]').click

    assert_text I18n.t('bulletins.crud.create.success')
    assert_selector 'h2', text: @new_title
  end

  test 'should send draft bulletin to moderation' do
    sign_in @user

    visit profile_path
    assert_selector 'h2', text: I18n.t('bulletins.titles.my')

    within find('tr', text: @bulletin_draft.title) do
      assert_text I18n.t('aasm.bulletin.states.draft')

      click_on I18n.t('aasm.bulletin.actions.to_moderate')
    end

    assert_text I18n.t('aasm.bulletin.transitions.to_moderate.success')

    within find('tr', text: @bulletin_draft.title) do
      assert_text I18n.t('aasm.bulletin.states.under_moderation')
    end
  end

  test 'admin should publish bulletin under moderation and see it on the main page' do
    sign_in @admin

    visit admin_root_path
    assert_selector 'h1', text: I18n.t('bulletins.titles.under_moderation')

    within find('tr', text: @bulletin_under_moderation.title) do
      accept_confirm I18n.t('bulletins.confirmation.publish') do
        click_on I18n.t('aasm.bulletin.actions.publish')
      end
    end

    assert_text I18n.t('aasm.bulletin.transitions.publish.success')

    # check on main
    visit root_path
    assert_selector 'h2', text: I18n.t('bulletins.titles.all')

    assert_text @bulletin_under_moderation.title
  end
end
