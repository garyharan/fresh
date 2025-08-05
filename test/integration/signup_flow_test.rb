require "test_helper"

class SignupFlowTest < ActionDispatch::IntegrationTest
  setup do
    Rails.application.load_seed
  end

  test "signup and deleting info" do
    visit new_user_path

    assert_difference("User.count", 1) do
      fill_in_user_registration_form
      fill_in_profile_section_1
      fill_in_profile_section_2
      fill_in_profile_section_3
      fill_in_profile_section_4

      assert_text "TestUser123"
      assert_text "Longueuil"
      assert_text "Want someday"
      assert_text "Non-monogamous"
      assert_text "5'10"
      assert_text "I am a test user."
    end

    assert_difference("User.count", -1) do
      click_link "Edit Account"
      click_button "Delete my account and all its data"
      assert_text "Your account and all associated data have been permanently deleted."
    end
  end

  private

  def fill_in_user_registration_form
    fill_in "Enter your email address", with: "test@example.com"
    fill_in "Enter your password", with: "password"
    check "user_terms_of_use"
    click_button "Create my account"
  end

  def fill_in_profile_section_1
 fill_in "Display name", with: "TestUser123"
    choose "Man", allow_label_click: true

    # required to allow easier finding for Capybara
    assert_selector "select.is_day_select"
    assert_selector "select.is_month_select"
    assert_selector "select.is_year_select"

    find("select.is_day_select").select("2")
    find("select.is_month_select").select("February")
    find("select.is_year_select").select("1990")

    fill_in "City", with: "Longueuil"
    fill_in "profile_state", with: "Quebec"
    fill_in "Country", with: "Canada"
    click_button "Next"
  end

  def fill_in_profile_section_2
    # genders we like
    find("label", text: "Men").click
    find("label", text: "Women").click

    # wants children
    find("label", text: "Want someday").click

    # relationship style
    find("label", text: "Non-monogamous").click

    fill_in "profile_height", with: "178"

    # For Smoking - Never
    all('label', text: 'Never').first.click

    # For Drinking - Occasionally
    all('label', text: 'Occasionally')[1].click

    click_button "Next"
  end

  def fill_in_profile_section_3
    file_input = page.find('#image_photo', visible: false)
    file_input.attach_file(Rails.root.join("test/fixtures/files/captain.jpeg"))
    click_button "Next"
  end

  def fill_in_profile_section_4
    click_link "Add the About Me card"
    select "My self-summary"
    fill_in "Write something...", with: "I am a test user."
    click_button "Create Card"
    click_button "Finish"
  end

end
