# frozen_string_literal: true

require 'application_system_test_case'

class SearchBulletinsTest < ApplicationSystemTestCase
  test 'search by title' do
    visit bulletins_path
    fill_in 'q_title_cont', with: 'Bus'
    click_on 'Search'

    assert_text 'Typical german Bus'
    refute_text 'Old-fashioned Coat'
  end

  test 'filter by state' do
    visit bulletins_path
    select 'published', from: 'q_state_eq'
    click_on 'Search'

    assert_text 'Typical german Bus'
    refute_text 'Brand new Car'
  end
end
