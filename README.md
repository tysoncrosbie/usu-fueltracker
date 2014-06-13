![USU Aviation logo](http://www.usufueltracker.com/images/usu-aviation.jpg)

# USU Aviation Fuel Tracker Application

## Prerequisites

* ```postgresql database```
* ```ruby 2.0.0```
* ```bundler```
* ```foreman``` (part of heroku toolbelt)
* ```chromedriver``` (for feature specs)

## Setup

Copy the appropriate ```database.yml.*``` file to ```database.yml```, within the config directory. Modify it to fit your environment. **PostgreSQL is used in production.**

Copy ```config/application.example.yml``` to ```config/application.yml``` and edit it appropriately to set environment variables.

From the root of the project run the following commands:

    bundle

## Running Locally

To run the application locally, use the following command from the root of the project:

    foreman start -f Procfile.dev

## Seeding

Seed the database with values (after running Foreman) by running:

    rake db:setup

## Development

### Branching

Create a separate branch for each story being worked on. New branches should be rooted in the ```staging``` branch. Here's a sample process to follow:

#### Creating a branch

1. ```git checkout staging```
1. ```git pull```
1. ... fix any merge conflicts ...
1. ```git checkout -b new-story```
1. ... work on your story, commit, push, etc. ...

#### Merging your branch into staging

1. ```git checkout staging```
1. ```git pull```
1. ... fix any merge conflicts, commit, push, etc. ...
1. ```git checkout new-story```
1. ```git merge staging```
1. ... fix any merge conflicts, run tests, commit, push, etc. ...
1. ```git checkout staging```
1. ```git merge new-story```
1. ... checkin and push ...

### Running Tests

Tests can be run individually or as a group.

Examples:

  1. Run all tests within in a single file:

      ```rspec ./spec/models/user_spec.rb```

  1. Run a specific test in a single file (by line number):

      ```rspec ./spec/models/user_spec.rb:6```

  1. Run all tests:

      ```rake spec```

*Strive to keep the tests up-to-date and passing.*

### Inspecting Emails

The ```mailcatcher``` gem is included in the development bundle and configured in ```development.rb```. Simply run the following command from the app directory:

    mailcatcher

Now, in development, all mail will be caught via SMTP on the local machine. Navigate to [http://localhost:1080/](http://localhost:1080/) to see the emails sent in development.

## Deployment

### Production

The production server houses the public-facing live application. Be very careful when deploying changes to the live application.

Run the following command to add a Git remote, so you can push changes to the production server:

    <!-- git remote add heroku git@heroku.com:usu-fueltracker.git -->

*If you don't have access to the production server, you can request it from [Tyson](mailto:tyson@tysoncrosbie.com).*

If changes involve updating the database schema or data, run the following commands when you deploy:

  1. ```heroku maintenance:on --app usufueltracker```
  1. ```git push heroku```
  1. ```heroku run rake db:migrate --app usufueltracker```
  1. *Any other rake tasks you may need to run go here...*
  1. ```heroku restart --app usufueltracker```
  1. *... wait for the production processes to start up ...*
  1. ```heroku maintenance:off --app usufueltracker```

If you're not changing the database schema or data, then you can probably just run:

    git push heroku

Be sure to monitor the deployment to ensure that it completes, the server restarts and the site is still publicly accessible.
