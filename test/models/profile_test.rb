require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @gathino = profiles(:one)
    @velvet = profiles(:two)
    @mariet = profiles(:three)

    @man = Gender.create!(label: 'Man')
    @woman = Gender.create!(label: 'Woman')
    @enby = Gender.create!(label: 'Non-Binary and/or Two Spirit Person')
  end

  test 'liked_by?(profile) when profile was liked by other profile' do
    Like.create! profile: @velvet, user: @gathino.user

    assert @velvet.liked_by?(@gathino.user)
  end

  test 'liked_by?(profile) when profile was not liked by other profile' do
    refute @gathino.liked_by?(@velvet.user)
  end

  test '#of_gender returns all the profile of a specific gender' do
    man = Gender.find_by(label: 'Man')

    assert(Profile.of_gender(man).all? { |p| p.gender.label == 'Man' })
  end

  test '.in_group returns all the profiles in a specific group' do
    @group = Group.create!(name: 'Test Group', description: "Testing", user: @gathino.user)

    @group.memberships.create(user: @gathino.user)
    @group.memberships.create(user: @velvet.user)


    assert_includes Profile.in_group(@group), @gathino
    assert_includes Profile.in_group(@group), @velvet
    refute_includes Profile.in_group(@group), @mariet
  end

  test '#attracted_to_gender returns all the profiles that are attracted to give genders' do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @enby.id, genders: [@enby])

    assert_includes Profile.attracted_to_genders(@gathino.genders), @velvet
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

    Like.create! profile: @gathino, user: @velvet.user

    assert_includes Profile.recommended(@gathino), @velvet
  end

  test '#recommended does not show profiles you have already liked or passed' do
    @gathino.update(gender: @man, genders: [@woman])
    @velvet.update(gender: @woman, genders: [@man])

    assert_includes Profile.recommended(@gathino), @velvet

    @gathino.user.likes.create! profile: @velvet
    refute_includes Profile.recommended(@gathino), @velvet
  end
end
