# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Adding genders"

if Gender.count.zero?
  Gender.create(
    [
      { label: "Woman" },
      { label: "Man" },
      { label: "Non-Binary and/or Two Spirit Person" }
    ]
  )
else
  puts "Already filled genders"
end

if Rails.env.development?
  if User.count.zero?
    (0..10).each do |number|
      u =
        User.create! email: Faker::Internet.email,
                     password: "asd0fadsfh",
                     confirmation_token: Devise.friendly_token

      p =
        Profile.create! user_id: u.id,
                        display_name: Faker::Name.name,
                        born_on: (18..99).to_a.sample.years.ago,
                        body: Faker::Lorem.paragraph,
                        gender_id: [1, 2, 3].sample

      image = p.images.create
      image.photo.attach(
        io:
          File.open(
            Rails.root.join("test/fixtures/files/seed/", "#{number}.png")
          ),
        filename: "#{number}.png"
      )
    end
  else
    puts "Users already exist"
  end
end
