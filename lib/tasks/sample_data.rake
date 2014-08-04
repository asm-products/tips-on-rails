require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Example",
                 last_name: "User",
                 email: "examples@tips.com",
                 password: "treehouse",
                 password_confirmation: "treehouse"
                 )
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "examples-#{n+1}@tips.com"
      password = "treehouse"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all
    20.times do
      title = Faker::Lorem.characters(10)
      description = Faker::Lorem.paragraph(2)
      code = Faker::Lorem.paragraph(2)
      references = Faker::Lorem.characters(10)
      users.each { |user| user.tips.create(title: title, description: description, code: code, references: references) }
    end

    10.times do
      users = User.all.limit(10).order("RAND()")
        users.each do |user|
      tips = Tip.all.limit(10).order("RAND()")
        tips.each do |tip|
          Bookmark.create(user_id: user.id, tip_id: tip.id) unless tip.bookmarked_by(user)
        end
      end
    end
  end
end