require 'faker'

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    standard: true
  )
end
users = User.all

50.times do
  Wiki.create!(
  title: Faker::Space.galaxy,
  body: Faker::MostInterestingManInTheWorld.quote,
  private: false
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
