# README

# Setup

    bundle install --local
    bundle exec rake db:create
    bundle exec rake db:migrate db:seed

# How to use

Run the tests and ensure that every worked well:

    bundle exec rspec spec

Do the refactoring, and run test again to make sure that you are not break something:

    bundle exec rspec spec

# How to rebuild

    bundle exec rake db:drop db:create db:migrate db:seed

# Caution!

This project is only for demonstration. It contans many bad pratices and not unreasonable bussiness logic. Here are some examples:

* Did not index foreign key column in database
* Did not git ignore config/database.yml
* Did not require user to login
* Did not validate the uniquess of user.email

So do not use the snippets in your production project. Instead, lean the principles.

