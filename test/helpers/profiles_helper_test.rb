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
end
