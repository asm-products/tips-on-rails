# Tips on Rails

Ever been in a situation where your just not sure where to start? How to implement a specific part of your rails application? Completely mystified about how to test for a specific behavior?

Tips on Rails was made for people just like you. It's here as a tool to enable Rails users to learn, post, and socialize about the latest and greatest tips out there!

## Getting started with Tips on Rails

Tips on Rails is ran on the Thin web server using environment variables. You'll need to complete the following steps to get it running.

**Create _.env_ file, with the following information:**

    PORT=5100 (your port number could be any four-digits)
    RACK_ENV=development
    DB_DATABASE=TipsonRails_development
    DB_USERNAME=localdev
    DB_PASSWORD=password 

**Create file _Procfile.dev_, with the following information:**

    web: bundle exec rails server thin -p $PORT -e $RACK_ENV

**In the command line, run:**

    bundle 

**Go to:**

    localhost:5100/ (use the port number you specified in the .env file)