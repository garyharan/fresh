require 'yaml'

puts "Adding genders" if Rails.env.production? || Rails.env.staging?

if Gender.count.zero?
  genders = YAML.load_file(Rails.root.join('test/fixtures/genders.yml'))
  genders.each do |key, fixture|
    gender = Gender.create label: fixture['label']
    puts "CREATING GENDER: #{gender.inspect}"
  end
else
  puts "Already filled genders"
end

if Rails.env.development? || Rails.env.test?
  if User.count < 10
    (0..10).each do |number|
      u =
        User.new email: Faker::Internet.email,
                 password: "asd0fadsfh",
                 confirmation_token: Devise.friendly_token
      u.skip_confirmation! if u.respond_to? :skip_confirmation!
      u.last_sign_in_at = DateTime.now
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
                    height: (150..200).to_a.sample
      p.save(validate: false)

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
