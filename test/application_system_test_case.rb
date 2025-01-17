# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  include AuthenticationHelpers

  def fixture_file_path(filename)
    Rails.root.join('test/fixtures/files', filename)
  end
end
