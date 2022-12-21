require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  setup do
    @gathino = profiles(:one)
    @velvet = profiles(:two)
    @mariet = profiles(:three)

    @man = Gender.create!(label: "Man")
    @woman = Gender.create!(label: "Woman")
    @enby = Gender.create!(label: "Non-Binary and/or Two Spirit Person")
  end

  test "liked_by?(profile) when profile was liked by other profile" do
    like = Like.create! profile: @velvet, user: @gathino.user

    assert @velvet.liked_by?(@gathino.user)
  end

  test "liked_by?(profile) when profile was not liked by other profile" do
    refute @gathino.liked_by?(@velvet.user)
  end

  test "accepts_nested_attributes_for :attractions" do
    p = @gathino
    p.attractions.destroy_all
    p.update(
      attractions_attributes: [
        { gender_id: Gender.first.id },
        { gender_id: Gender.last.id }
      ]
    )
    assert_equal 2, p.attractions.count
  end

  test "#of_gender returns all the profile of a specific gender" do
    man = Gender.find_by(label: "Man")

    assert Profile.of_gender(man).all? { |p| p.gender.label == "Man" }
  end

  test "#recommended matches you to people you would be attracted to and vice-versa" do
    @gathino.update(gender_id: @man.id, genders: [@woman])
    @velvet.update(gender_id: @woman.id, genders: [@man])
    @mariet.update(gender_id: @enby.id, genders: [@enby])

    # hetero
    assert_includes Profile.recommended(@gathino),
                    @velvet,
                    "Should show hetero women"
    assert_includes Profile.recommended(@velvet),
                    @gathino,
                    "Should show hetero men"
    refute_includes Profile.recommended(@velvet),
                    @mariet,
                    "Should not see an enby"
    refute_includes Profile.recommended(@gathino),
                    @mariet,
                    "Should not see an enby"

    # # open to all genders
    @gathino.update(genders: [@man, @woman, @enby])
    assert_includes Profile.recommended(@gathino),
                    @velvet,
                    "because they each like the other person's gender"
    refute_includes Profile.recommended(@gathino),
                    @mariet,
                    "because Mariet is not interested in men"

    @gathino.update(gender: @man, genders: [@man, @woman, @enby])
    @velvet.update(gender: @enby, genders: [@man, @enby])

    assert_includes Profile.recommended(@velvet), @gathino
    assert_includes Profile.recommended(@gathino), @velvet
  end

  test "#recommended does not show profiles you have already liked or passed" do
    @gathino.update(gender: @man, genders: [@woman])
    @velvet.update(gender: @woman, genders: [@man])

    assert_includes Profile.recommended(@gathino), @velvet
    @gathino.user.likes.create! profile: @velvet
    refute_includes Profile.recommended(@gathino), @velvet
  end
end
