require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    puts ">>> * Deleting all Bookmarks"
    Bookmark.delete_all
    puts ">>> * Deleting all Tips"
    Tip.delete_all
    puts ">>> * Deleting all Users"
    User.delete_all

    puts ">>> * Seeding Users"
    User.create!(
      first_name: "Example",
      last_name: "User",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "examples-#{n+1}@tips.com"
      password = "password"
      User.create!(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        password_confirmation: password
      )
    end
    puts ">>> * Done! Seeded #{User.count} users."
    
    puts ">>> * Seeding Tips"
    users = User.all
    20.times do
      title = Faker::Lorem.sentence(rand(3..6)).chomp('.')
      description = Faker::Lorem.paragraph(rand(1..4))
      body = Faker::Lorem.paragraphs(rand(2..6)).join("\n\n")
      users.each { |user| user.tips.create(title: title, description: description, body: body) }
    end
    puts ">>> * Done! Seeded #{Tip.count} tips."

    puts ">>> * Seeding Bookmarks"
    10.times do
      users = User.all.limit(10).order("RAND()")
        users.each do |user|
      tips = Tip.all.limit(10).order("RAND()")
        tips.each do |tip|
          Bookmark.create(user_id: user.id, tip_id: tip.id) unless tip.bookmarked_by(user)
        end
      end
    end
    puts ">>> * Done! Seeded #{Bookmark.count} bookmarks."
  end
end