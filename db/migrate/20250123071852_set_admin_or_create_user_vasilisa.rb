class SetAdminOrCreateUserVasilisa < ActiveRecord::Migration[7.2]
  USER_EMAIL = 'vasiliqa13@gmail.com'.freeze
  USER_NAME = 'Vasilisa'.freeze

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
