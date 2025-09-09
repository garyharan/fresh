require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @gathino = profiles(:one)
    @velvet = profiles(:two)
    @mariet = profiles(:three)

    @man = Gender.create!(label: 'Man')
    @woman = Gender.create!(label: 'Woman')
    @enby = Gender.create!(label: 'Non-Binary')
  end

  test 'maximum_distance delegation' do
    @gathino.maximum_distance = 80085
    assert_equal 80085, @gathino.maximum_distance
  end

  test '#of_gender returns all the profile of a specific gender' do
    man = Gender.find_by(label: 'Man')

    assert(Profile.of_gender(man).all? { |p| p.gender.display_label == 'Man' })
  end

  test '#attracted_to_gender returns all the profiles that are attracted to give genders' do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @enby.id, genders: [@enby])

    assert_includes Profile.attracted_to_genders(@gathino.genders), @velvet
  end

  test '#with_coordinates does not show people without latitude and longitude' do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @woman.id, genders: [@man], latitude: nil, longitude: nil)

    assert_includes Profile.with_coordinates, @velvet
    refute_includes Profile.with_coordinates, @mariet
  end

  test '#recommended only shows people with latitude and longitude' do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @woman.id, genders: [@man], latitude: nil, longitude: nil)

    assert_includes Profile.recommended(@gathino), @velvet
    refute_includes Profile.recommended(@gathino), @mariet
  end

  test '#recommended matches you to people you would be attracted to and vice-versa' do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @enby.id, genders: [@enby])

    # hetero
    assert_includes Profile.recommended(@gathino), @velvet, 'Should show hetero women'
    assert_includes Profile.recommended(@velvet), @gathino, 'Should show hetero men'
    refute_includes Profile.recommended(@velvet), @mariet, 'Should not see an enby'
    refute_includes Profile.recommended(@gathino), @mariet, 'Should not see an enby'
  end

  test '#recommended matches you to people you would be attracted to and vice-versa even with multiple attractions' do
    @gathino.update(gender_id: @man.id,  genders: [@woman, @enby])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @enby.id,  genders: [@man])

    assert_includes Profile.recommended(@gathino), @velvet
    assert_includes Profile.recommended(@gathino), @mariet
  end

  test '#recommended recommends you the person you get recommended to' do
    @gathino.update(gender: @man, genders: [@woman, @enby])
    @velvet.update(gender: @enby, genders: [@man, @enby])

    assert_includes Profile.recommended(@velvet), @gathino
    assert_includes Profile.recommended(@gathino), @velvet
  end

  test '#recommended shows you profiles of people you did not like yet even if they liked you' do
    @gathino.update(gender: @man, genders: [@woman, @enby])
    @velvet.update(gender: @enby, genders: [@man, @enby])

    Assessment.create! from_profile: @velvet, to_profile: @gathino, kind: :liked

    assert_includes Profile.recommended(@gathino), @velvet
  end

  test '#recommended does not show profiles you have already liked or passed' do
    @gathino.update(gender: @man, genders: [@woman])
    @velvet.update(gender: @woman, genders: [@man])

    assert_includes Profile.recommended(@gathino), @velvet

    Assessment.create!(from_profile: @gathino, to_profile: @velvet, kind: :liked)
    refute_includes Profile.recommended(@gathino), @velvet
  end

  test "#recommended does not show people beyond the distance you chose" do
    @gathino.user.update(distance: 10_000)
    @gathino.update(gender: @man, genders: [@woman])
    @velvet.update(gender: @woman, genders: [@man])
    @mariet.update(gender: @woman, genders: [@man])

    assert Profile.recommended(@gathino).none? { |p| p.distance > 10_000 }
  end

  test "#recommended only shows you non-monogamous profiles it is your preference" do
    @gathino.update(gender: @man, genders: [@woman, @enby])
    @velvet.update(gender: @enby, genders: [@man, @enby])
    @gathino.update(only_show_my_relationship_style: true)

    @gathino.update(relationship_style: "Non-monogamous")
    @velvet.update(relationship_style: "Monogamous")

    assert_not_includes Profile.recommended(@gathino), @velvet
  end

  test "adds unique public_code on creation" do
    user = User.create! email_address: "john@doe.com", password: "password"
    profile = Profile.new user: user, display_name: "John Doe", born_on: 18.years.ago, gender: Gender.first, city: "Saint-Hubert", state: "QC", country: "Canada"
    profile.step = 1
    profile.save!

    assert_not_nil profile.public_code
  end

  test "has_many partnerships association" do
    partnership = Partnership.create!(from_profile: @gathino, to_profile: @velvet, status: :unconfirmed)
    assert_includes @gathino.partnerships, partnership
  end

  test "calculates the latitude and longtitude after validation if the location changed" do
    @gathino.update(latitude: nil, longitude: nil)
    assert_nil @gathino.latitude
    assert_nil @gathino.longitude
    @gathino.update(city: "Montreal", state: "QC", country: "Canada")
    assert_not_nil @gathino.latitude
    assert_not_nil @gathino.longitude
  end
end
