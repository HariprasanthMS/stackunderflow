User.create!(name:  "Admin User",
  email: "admin@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

10.times do |n|
name  = Faker::Name.name
email = "user-#{n+1}@example.com"
password = "foobar"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end