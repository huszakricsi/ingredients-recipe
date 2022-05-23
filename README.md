# README

In order to get the application running you need to do as follows:

Make sure that you are using a ruby version which is definied in .ruby-version

Execute: bundle

Execute: "yarn install" for client side dependencies

Make sure the configuration is correct of the two yaml files ( check the .example files ):
  * config\database.yml
  * config\configuration.yml

Initialize database:
  * rake db:create
  * rake db:migrate
  * rake db:seed This step is optional, but makes it easier to get good starting data to check out the application features

After the steps above, you can start the application by executing "rails s"

You can generate test coverage by setting the SIMPLECOV environment variable to true: "SIMPLECOV=true rspec" which should be 100%

I was focusing more on the backend than the frontend since you are using React, but I would be happy to have a chance to learn it, even in the part of my free time if needed :)
