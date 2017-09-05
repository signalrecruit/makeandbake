# README

![Build Status](https://travis-ci.org/paa-yaw/makeandbake.svg?branch=develop)

# Project Name: MakeAndBake

# Brief Description
 * [Brief Description Here](https://github.com/paa-yaw/makeandbake/blob/master/app_description.md)



# Ruby and Rails Versions

* ruby 2.2.1p85

* Rails 4.2.5.1


# System Dependencies

* check [Here](https://github.com/paa-yaw/makeandbake/blob/master/Gemfile)

# App Configuration and Setup

* NOTE: you must have the following installed:

* [ruby(2.2.1p85) installation here](https://www.ruby-lang.org/en/downloads/)

* [rails(4.2.5.1) installation here](http://railsinstaller.org/en)

* [how to setup rails with postgres here](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres) OR
[here](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04)

# Getting Started

* run the following commands:

```
  mkdir app_dir

  cd app_dir

  git clone https://github.com/paa-yaw/makeandbake.git
  
  cd app_dir/makeandbake_app

  bundle install

  bin/rails s

```  
# User Credentials
  * [check here](https://github.com/paa-yaw/makeandbake/blob/master/app_description.md#user-credentials)


# Database initialization

* NOTE: you must already have postgres setup with rails
* In your database.yml setup your username and password for development and production using environment variables like so:

```
  
development:
  <<: *default
  host: localhost
  username: <%= ENV['MAKEANDBAKE_DATABASE_USERNAME'] %> 
  password: <%= ENV['MAKEANDBAKE_DATABASE_PASSWORD'] %>
  database: makeandbake_development

production:
  <<: *default
  database: makeandbake_production
  username: makeandbake
  password: <%= ENV['MAKEANDBAKE_DATABASE_PASSWORD'] %>



```

 
# How to run the test suite

* NOTE THE FOLLOWING:

  * RSpec is the tool used to run the test suit. Please make sure that it's installed and configured properly. [resource here](https://github.com/rspec/rspec-rails)

  ## the current test suite is INCOMPLETE AND BROKEN!!!
    * 277 examples, 84 failures, 12 pending
    * You have to improve upon the test suite to have all 277 examples passing.

  * You can run the test suite by running either of the following command:

  ```
    bundle exec bin/rake #to run all rspec tests 
    OR
    bundle exec rspec

  ```

  * To run tests on specific files run the following command:
  
    for instance, to run tests written for app/shops_controller.rb

  ```
    bundle exec rspec spec/controllers/shops_controller_spec.rb 

  ```
# License  

MIT License

Copyright (c) [2017] [Paa Yaw](https://github.com/paa-yaw)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

