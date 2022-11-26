require "test_helper"

class CardsHelperTest < ActionView::TestCase
  test "#cards_select_options" do
    assert_equal [
                   ["My self-summary", :self_summary],
                   ["What others say about me", :what_others_say_about_me],
                   ["What I definitely am not", :things_i_am_not]
                 ],
                 cards_select_options("about_me")
  end
end
