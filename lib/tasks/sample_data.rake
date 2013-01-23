namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_groups
  end
end

def make_users
  admin = User.create!(name: "Admin User",
   email:       "admin@maumercado.com",
   password:    "foobar",
   password_confirmation: "foobar")

  admin.roles=(['admin'])

  admin.save
  
  30.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@maumercado.com"
    password  = "password1"
    User.create!(name:      name,
     email:                 email,
     password:              password,
     password_confirmation: password)
  end
end

def make_groups
  10.times do |n|
    name = Faker::Company.name
    Group.create!(name: name)
  end
end