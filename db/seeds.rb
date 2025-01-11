# frozen_string_literal: true

# Categories
%w[Клавиши Двери Лужи].each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# Images
images_paths = { 'Клавиши' => Rails.root.join('db/seeds/images/key.jpg'),
                 'Двери' => Rails.root.join('db/seeds/images/door.jpg'),
                 'Лужи' => Rails.root.join('db/seeds/images/puddle.jpg') }

# Users
3.times do
  User.create!(
    email: Faker::Internet.email,
    name: Faker::Name.name
  )
end

# Bulletins
users = User.all
ActiveRecord::Base.transaction do
  users.each do |user|
    rand(0..4).times do
      category = Category.all.sample
      image = images_paths[category.name]

      user.bulletins.create!(
        category:,
        description: Faker::Lorem.paragraph_by_chars(number: rand(1..Bulletin.description_max_length)),
        image:,
        state: Bulletin.aasm.states.map(&:name).sample,
        title: Faker::Lorem.paragraph_by_chars(number: rand(1..Bulletin.title_max_length))
      )
    end
  end
end
