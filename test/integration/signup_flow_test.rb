require "test_helper"

class SignupFlowTest < ActionDispatch::IntegrationTest
  setup do
    Rails.application.load_seed
  end

  test "signup flow" do
    visit "/"

    click_link "Get started"

    fill_in "Your email", with: "user@host.com"
    fill_in "A password", with: "$1625df123"

    click_on "Next you will setup a profile"

    # step 1
    assert page.has_content? "Display name"
    fill_in(id: "profile_display_name", with: "Buster")

    assert page.has_content? "Gender"
    find('label', text: 'Man').click

    assert page.has_content? "Born on"
    select('6', from: 'profile_born_on_3i')
    select('October', from: 'profile_born_on_2i')
    select('1978', from: 'profile_born_on_1i')

    assert page.has_content? "Location"
    fill_in(id: "profile_city", with: "Saint-Hubert")
    fill_in(id: "profile_state", with: "Quebec")
    fill_in(id: "profile_country", with: "Canada")

    click_on "Next"

    # step 2
    assert page.has_content? "I am interested in"
    find('label', text: 'Women').click

    assert page.has_content? "Children"
    find('label', text: "Have & don't want more").click

    assert page.has_content? "Relationship Style"
    find('label', text: "Non-monogamous").click

    assert page.has_content? "Height"
    fill_in(id: "profile_height", with: "178")
    assert page.has_content? "5'10\""

    assert page.has_content? "Smoking"
    find_by_id('possible_smoking_options').find('label', text: 'Never').click

    assert page.has_content? "Drinking"
    find_by_id('possible_drinking_options').find('label', text: 'Occasionally').click

    click_on "Next"

    # step 3
    assert page.has_content? "Upload photos"
    assert page.has_content? "Upload at least one photo to continue"

    find("input[multiple='multiple']").set(Rails.root + "test/fixtures/files/gathino.png")
    refute page.has_content? "Upload at least one photo to finish"

    click_on "Next"

    # step 4
    assert page.has_content? "About me"
    assert page.has_content? "Fill out the About me section to finish"
    click_on "Add the About me card"
    fill_in(id: "card_content", with: "I am a very nice person")
    click_on "Create Card"
    assert page.has_content? "I am a very nice person"
    refute page.has_content? "Fill out the About me section to finish"

    # step 5
    click_on "Finish"

    assert page.has_content? "Buster"
    assert page.has_content? "44yo • Saint-Hubert" # add +1 every 6th of October
    assert page.has_content? "I am a very nice person"
    assert page.has_content? "Add the Aspirations card"
  end
end
