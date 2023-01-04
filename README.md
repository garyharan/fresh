# ❤️ Fresh.Dating

## An honest way to date

Too many dating site hang a proverbial carrot in front of people, preying on a manufactured desperation and asking for
way too much money for a service they provide poorly.

Fresh.Dating aims to offer people a reasonable dating tool.  In the past sites like eHarmony and Match.com would use
dead profiles to their users.  Over 90% of their profiles are inactive but they still show them.  This is a dishonest
practice and it has dire consequences on online dating:

* Men stop spending time on good introduction messages because 9 out of 10 messages they send are offline
* Men start sending shorter and less inspired messages
* Women are annoyed by the number of "Hey wassup" messages they get
* Women stop logging in because they only get uninspired messages
* Men get fed up and a vicious cycle emerges where quality degrades over time

Fresh.Dating will encourage people not to waste their time.  It will tell you in all honesty if you have no one active
near you.

## Setup instructions

To run the app locally you will need:

* Postgresql
* Redis
* Yarn
* Rails
* Ruby of course

A few commands you will need to run:

* bundle
* rails db:create:all
* rails db:seed

And the rest is pretty common Rails setup yack shaving.

## Testing the app locally

You can run the integration tests by running `rails test test/integration/`.

If you want to add a test and see the browser while you are adding steps to the
test you can switch the configuration in `test_helper.rb` to use
the `selenium_chrome` driver instead of the `selenium_chrome_headless` driver

Happy hacking!
