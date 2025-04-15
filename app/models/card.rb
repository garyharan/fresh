class Card < ApplicationRecord
  belongs_to :profile

  KINDS = {
    about_me: %i[self_summary what_others_say_about_me things_i_am_not],
    aspirations: %i[
      what_i_do_with_my_life
      current_goal
      would_be_known_for
      dream_job
    ],
    talents: %i[really_good_at i_like_to_make my_worst_quality],
    traits: %i[
      first_thing_people_notice_about_me
      my_style_described_as
      favorite_thing_about_me
      weirdest_quirk
    ],
    projects: %i[retirement_plan dream_house dream_vacation],
    media: %i[favorite_books favorite_bands favorite_movies favorite_shows],
    needs: %i[
      things_i_cant_live_without
      things_i_want_in_a_partner
      food_i_cant_live_without
    ],
    hobbies: %i[
      i_spend_lots_of_time_thinking_about
      hobby_i_want_to_learn
      i_spent_too_much_time_on
    ],
    outdoors: %i[
      my_favorite_outdoor_activity
      my_favorite_outdoor_place
      my_favorite_outdoor_memory
    ],
    cooking: %i[
      best_meal_i_make
      favorite_holiday_food
      something_i_cooked_once_but_never_again
    ],
    eating: %i[
      munchies
      restaurant_i_been_to_the_most
      favorite_restaurant
      favorite_cuisine
      snob_about
    ],
    dating: %i[message_me_if before_we_date_let_me_know_this first_date]
  }.freeze
end
