class SetAdminOrCreateUser < ActiveRecord::Migration[7.2]
  USER_EMAIL = 'googopus@gmail.com'.freeze
  USER_NAME = 'S'.freeze

  def up
    user = User.find_by(email: USER_EMAIL)
    if user
      user.update(admin: true)
    else
      User.create(email: USER_EMAIL, name: USER_NAME, admin: true)
    end
  end

  def down
    user = User.find_by(email: USER_EMAIL)
    user.update(admin: false) if user
  end
end
