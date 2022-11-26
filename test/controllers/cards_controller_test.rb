require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:gathino)

    @card = cards(:one)
  end

  test "should create card" do
    assert_difference("Card.count") do
      post cards_url(
             format: :turbo_stream,
             params: {
               card: {
                 kind: "talents",
                 title: "really_good_at",
                 content: "Making grilled cheese"
               }
             }
           )
    end

    card = Card.last

    assert_equal "talents", card.kind
    assert_equal "really_good_at", card.title
    assert_equal "Making grilled cheese", card.content

    assert_response :success
  end

  test "should update card" do
    patch card_url(@card, format: :turbo_stream),
          params: {
            card: {
              content: "I need someone who is capable"
            }
          }

    assert_response :success
  end

  # test "should destroy card" do
  #   assert_difference("Card.count", -1) do
  #     delete card_url(@card, format: :turbo_stream)
  #   end
  #   assert_response :success
  # end
end
