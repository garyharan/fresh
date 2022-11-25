class Card < ApplicationRecord
  belongs_to :profile

  KINDS = {
    about_me: %i[self_summary what_others_say_about_me things_i_am_not]
  }.freeze

  #   aspirations: %i[
  #     what_i_do_with_my_life
  #     current_goal
  #     would_be_known_for
  #     dream_job
  #   ],
  #   talent: %i[really_good at i_like_to_make my_worst_quality],
  #   traits: %i[
  #     first_thing_people_notice
  #     my_style_described_as
  #     favorite_thing_about_me
  #     my_golden_rule
  #     weirdest_quirk
  #   ],
  #   media: %i[favorite_books favorite_bands favorite_movies favorite_shows],
  #   needs: %i[
  #     things_i_cant_live_without
  #     things_i_want_in_a_partner
  #     food_i_cant_live_without
  #   ],
  #   hobbies: %i[
  #     i_spend_lots_of_time_thinking_about
  #     hobby_i_want_to_learn
  #     i_spent_too_much_time_on
  #   ],
  #   projects: %i[retirement_plan dream_house dream_vacation],
  #   moments: %i[
  #     typical_friday_night
  #     perfect_day
  #     best_day_of_my_life_was
  #     ideal_weekend
  #   ],
  #   secrets: %i[
  #     most_private_confession
  #     last_embarassing_moment
  #     my_biggest_regret
  #     what_made_me_the_saddest_at_the_time
  #   ],
  #   dating: %i[message_me_if before_we_date_let_me_know_this first_date],
  #   travel: %i[
  #     dreamiest_place_i_visited
  #     place_i_would_not_go_back_to
  #     next_destinations
  #     what_i_get_out_of_traveling
  #   ],
  #   outdoors: %i[
  #     my_favorite_outdoor_activity
  #     my_favorite_outdoor_place
  #     my_favorite_outdoor_memory
  #   ],
  #   books: %i[
  #     my_favorite_book
  #     my_favorite_author
  #     my_favorite_genre
  #     next_book_made_in_a_movie
  #   ],
  #   movies: %i[
  #     best_movie_of_all_time
  #     last_movie_i_saw
  #     last_movie_to_make_me_cry
  #     favorite_director
  #     favorite_genre
  #     film_that_changed_my_life
  #   ],
  #   eating: %i[
  #     munchies
  #     restaurant_i_been_to_the_most
  #     favorite_food
  #     favorite_restaurant
  #     favorite_cuisine
  #     snob_about
  #   ],
  #   cooking: %i[
  #     best_meal_i_make
  #     favorite_holiday_food
  #     something_i_cooked_once_but_never_again
  #   ]
  # }
end
