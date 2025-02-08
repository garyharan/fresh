require 'yaml'

puts "Adding genders" if Rails.env.production? || Rails.env.staging?

if Gender.count.zero?
  genders = YAML.load_file(Rails.root.join('test/fixtures/genders.yml'))
  genders.each do |key, fixture|
    gender = Gender.create label: fixture['label']
    puts "CREATING GENDER: #{gender.inspect}"
  end
end

if Rails.env.development? || Rails.env.test?
  if User.count < 20
    (0..10).each do |number|
      u =
        User.new email_address: Faker::Internet.email,
                 password_digest: BCrypt::Password.create("testtest")
      u.skip_confirmation! if u.respond_to? :skip_confirmation!
      u.save(validate: false)

      p =
        Profile.new user_id: u.id,
                    display_name: Faker::Name.name,
                    born_on: (18..99).to_a.sample.years.ago,
                    gender_id: Gender.all.to_a[number % 3].id,
                    genders: Gender.all.sample(2),
                    city: %w[Longueuil Montreal Laval].sample,
                    state: "Quebec",
                    country: "Canada",
                    children: Profile::POSSIBLE_CHILDREN_CONFIGURATIONS.sample,
                    relationship_style:
                      Profile::POSSIBLE_RELATIONSHIP_STYLES.sample,
                    drinking: Profile::POSSIBLE_DRINKING_OPTIONS.sample,
                    smoking: Profile::POSSIBLE_SMOKING_OPTIONS.sample,
                    height: (150..200).to_a.sample,
                    longitude: [-73.7530656, -73.43277933544931, -73.5698065].sample,
                    latitude: [45.5757802, 45.5031824, 45.498372796415964].sample

      p.save(validate: false)

      4.times do
        image = p.images.create
        image.photo.attach(
          io:
            File.open(
              Rails.root.join("test/fixtures/files/seed/", "#{number}.png")
            ),
          filename: "#{number}.png"
        )
      end

      p.cards.create kind: 'about_me', title: 'self_summary', content: "Half French and Half French Canadian but totally bilingual. Fan of cuddling and much more..."
      p.cards.create kind: 'aspirations', title: 'current_goal', content: "Take over DOGE and give the government back to its people"
    end
  end
end
