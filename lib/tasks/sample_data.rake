namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_scores
  end
end

def make_users
  admin = User.create!(name:     "Joe Bloggs",
                       email:    "example@tetrispals.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  30.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@tetrispals.org"
    password  = "foobar"
    u = User.new(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
    imgName = "public/uploads/user/faces/meme(#{n+6}).png"
    u.image.store!(File.open(File.join(Rails.root, imgName)))
    u.save!
  end
end

def make_microposts
  users = User.all(limit: 12)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..12]
  followers      = users[3..10]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_scores
  r= Random.new
  User.all.each { |u| 10.times { u.high_scores.create!(score:  r.rand(110..9987)) } }
end
