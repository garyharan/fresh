require "test_helper"

class ProfilesHelperTest < ActionView::TestCase
  test "#imperialize should convert to imperial" do
    assert_equal "5'10\"", imperialize(178)
  end

  test "#previewing? should return true if the current user's profile matches the given profile" do
    Current.stub :user, users(:gathino) do
      assert previewing?(Current.user.profile)
    end
  end

  test "#previewing? should return false if the current user's profile does not match the given profile" do
    Current.stub :user, users(:gathino) do
      refute previewing?(users(:velvet).profile)
    end
  end

  test "#previewing? should return false if there is no current user" do
    Current.stub :user, nil do
      refute previewing?(users(:gathino).profile)
    end
  end

  test "#assessed? should return true if an assessment exists from the current user's profile to the given profile" do
    Current.stub :user, users(:gathino) do
      Assessment.stub :exists?, true do
        assert assessed?(users(:velvet).profile)
      end
    end
  end

  test "#assessed? should return true if the profile was blocked" do
    Current.stub :user, users(:gathino) do
      Assessment.stub :exists?, true do
        assert blocked?(users(:velvet).profile)
      end
    end
  end

  test "#assessed? should return false if no assessment exists from the current user's profile to the given profile" do
    Current.stub :user, users(:gathino) do
      Assessment.stub :exists?, false do
        refute assessed?(users(:velvet).profile)
      end
    end
  end

  test "#assessed? should return false if there is no current user" do
    Current.stub :user, nil do
      refute assessed?(users(:velvet).profile)
    end
  end

  test "#matched? should return true if both profiles liked each other" do
    Current.stub :user, users(:gathino) do
      Assessment.create!(from_profile: users(:gathino).profile, to_profile: users(:velvet).profile, kind: :liked)
      Assessment.create!(from_profile: users(:velvet).profile, to_profile: users(:gathino).profile, kind: :liked)

      assert matched?(users(:velvet).profile)
    end
  end

  test "#matched? should return false if only one profile liked the other" do
    Current.stub :user, users(:gathino) do
      Assessment.create!(from_profile: users(:gathino).profile, to_profile: users(:velvet).profile, kind: :liked)

      refute matched?(users(:velvet).profile)
    end
  end

  test "#matched? should return false if profiles passed on each other" do
    Current.stub :user, users(:gathino) do
      Assessment.create!(from_profile: users(:gathino).profile, to_profile: users(:velvet).profile, kind: :passed)
      Assessment.create!(from_profile: users(:velvet).profile, to_profile: users(:gathino).profile, kind: :passed)

      refute matched?(users(:velvet).profile)
    end
  end

  test "#matched? should return false if there is no current user" do
    Current.stub :user, nil do
      refute matched?(users(:velvet).profile)
    end
  end

  test "#blocked? should return true if an assessment exists from the current user's profile to the given profile" do
    Current.stub :user, users(:gathino) do
      Assessment.stub :exists?, true do
        assert blocked?(users(:velvet).profile)
      end
    end
  end

  test "#blocked? should return false if no assessment exists from the current user's profile to the given profile" do
    Current.stub :user, users(:gathino) do
      Assessment.stub :exists?, false do
        refute blocked?(users(:velvet).profile)
      end
    end
  end

  test "#blocked? should return false if there is no current user" do
    Current.stub :user, nil do
      refute blocked?(users(:velvet).profile)
    end
  end
end
