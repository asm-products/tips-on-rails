# Tips on Rails

<a href="https://assembly.com/tips-on-rails/bounties?utm_campaign=assemblage&utm_source=tips-on-rails&utm_medium=repo_badge"><img src="https://asm-badger.herokuapp.com/tips-on-rails/badges/tasks.svg" height="24px" alt="Open Tasks" /></a>

[![Code Climate](https://codeclimate.com/github/asm-products/tips-on-rails/badges/gpa.svg)](https://codeclimate.com/github/asm-products/tips-on-rails)

Ever been in a situation where your just not sure where to start? How to implement a specific part of your rails application? Completely mystified about how to test for a specific behavior?

Tips on Rails was made for people just like you. It's here as a tool to enable Rails users to learn, post, and socialize about the latest and greatest tips out there!

## Getting started with Tips on Rails

Tips on Rails is ran on the Thin web server using environment variables. You'll need to complete the following steps to get it running.

**Create _.env_ file, with the following information:**

    PORT=5300 (this specific port is needed to work with GitHub oauth)
    RACK_ENV=development
    DB_DATABASE=TipsonRails_development
    DB_USERNAME=localdev
    DB_PASSWORD=password
    GITHUB_KEY=
    GITHUB_SECRET=

Send email to ohlincik [at] gmail [dot] com and request the GitHub credentials for testing in Development.

**Create file _Procfile.dev_, with the following information:**

    web: bundle exec rails server thin -p $PORT -e $RACK_ENV

**In the command line, run:**

    bundle

**Make sure you have the foreman gem instaled:**

    foreman

If the Terminal tells you that it can't find it, you'll have to get it. Go to https://github.com/ddollar/foreman and follow the instructions.


**Get your development and test databases ready:**

    foreman run rake db:setup
    foreman run rake db:migrate RAILS_ENV=test

**Start the application:**

    foreman start -f Procfile.dev

**Go to:**

    http://localhost:5300/

## Load fake data for Development

We prepared some fake data you can load immediately to start playing around with the app. To get this loaded just run the following:

    foreman run rake db:load_fake_data

This will do the following:

* Delete all bookmarks (if any exist already)
* Delete all tips (if any exist already)
* Delete all users (if any exist already)
* Create 30 randomly named users
* Create random number of tips (5..20) for each user
* Create random number of bookmarks for random tips for random users

## Professional network for Rails developers

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assembly.com/tips-on-rails](https://assembly.com/tips-on-rails).

### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assembly.com](https://assembly.com) to learn more.
