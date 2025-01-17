# frozen_string_literal: true

require 'application_system_test_case'

class SearchBulletinsTest < ApplicationSystemTestCase
  setup do
    @bulletin_with_unique_title = bulletins(:unique_title)
    @bulletin_with_unique_category = bulletins(:unique_category)

    @category = categories(:unique)

    @user = users(:user)
    @admin = users(:admin)
  end

  test 'search by title' do
    visit bulletins_path
    fill_in 'q_title_cont_any', with: @bulletin_with_unique_title.title[..4]
    click_on I18n.t('search.links.submit')

    assert_text @bulletin_with_unique_title.title
    refute_text @bulletin_with_unique_category.title
  end

  test 'search by category' do
    visit bulletins_path
    select @bulletin_with_unique_category.category.name, from: 'q_category_id_eq'
    click_on I18n.t('search.links.submit')

    assert_text @bulletin_with_unique_category.title
    refute_text @bulletin_with_unique_title.title
  end

  test 'search by state' do
    sign_in @admin

    visit admin_bulletins_path
    select 'Draft', from: 'q_state_eq'
    click_on I18n.t('search.links.submit')

    assert_selector 'td', text: 'Draft', count: Bulletin.where(state: 'draft').count
    assert_no_selector 'td', text: 'Published'
    assert_no_selector 'td', text: 'Rejected'
    assert_no_selector 'td', text: 'Under moderation'
    assert_no_selector 'td', text: 'Archived'
  end
end
