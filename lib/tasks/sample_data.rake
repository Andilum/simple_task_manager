namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(1)
      description = Faker::Lorem.sentence(5)
      state = ["new", "started", "finished", "accepted", "rejected"].shuffle[0]
      responsible_user_id = (1..6).to_a.shuffle[0]
      users.each { |user| user.stories.create!(title: title, description: description, state: state, responsible_user_id: (1..6).to_a.shuffle[0]) }
    end
  end
end