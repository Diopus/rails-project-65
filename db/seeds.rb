# frozen_string_literal: true

images = ['key.jpg', 'door.jpg', 'puddle.jpg']

%w[Клавиши Двери Лужи].each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# Users
User.find_or_create_by(email: 'pochta@pochta.com') do |user|
  user.password = '123456'
end

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

# Posts
users = User.all
users.each do |user|
  rand(0..2).times do
    user.bulletin.create!(
      category: Category.all.sample,
      description: Faker::Lorem.paragraph_by_chars(number: rand(Post.description_max_length)),
      image: images.sample,
      title: Faker::Lorem.paragraph_by_chars(number: rand(1..Post.title_max_length))
    )
  end
end
