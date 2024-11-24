# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'check github auth' do
    post auth_request_path('github')
    assert_response :redirect
  end

  test 'create' do
    # skip('reason for skipping the test')
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
    assert_response :redirect

    user = User.find_by(email: auth_hash[:info][:email].downcase)

    assert user
    assert signed_in?
  end

  test 'should route to request' do
    assert_routing({ method: 'post', path: '/auth/github' },
                   { controller: 'web/auth', action: 'request', provider: 'github' })
  end

  test 'should route to callback' do
    assert_routing({ method: 'get', path: '/auth/github/callback' },
                   { controller: 'web/auth', action: 'callback', provider: 'github' })
  end
end
