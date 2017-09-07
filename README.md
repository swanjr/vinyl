# Welcome to Vinyl

Vinyl is a web application for managing simple record metadata for a record collection.  
It is also a proof of concept of using the new Rails 5.1.3 integration with Elm 0.18. Most of the application crud functions were generated using rails scaffold. The RecordController new functionality was then replaced with a Elm frontend application form that communicates with a Rails API backend controller. During the development of this slice I also incorporated parts of my personal development process to give you a feel how I like to code, configure rspec, etc. 

Main points of interest
* app/javascript/packs/Mail.elm - Client-side Elm app for created a new record.
* app/api/v1/records_controller.rb - Rest API controller for creating a new record. Used by the Elm app.
* app/services/add_record_service.rb - Business logic related to creating a new record and album. If I had time, this was also where I was going to trigger a job to lookup record metadata from Spotify's API in the background: https://developer.spotify.com/web-api/endpoint-reference/.
* app/views/layouts/elm_layout.html.erb - Layout that loads the Elm app.
* spec/active_record_helper.rb - Spec helper that loads only ActiveRecord related classes. Allows testing of significantly more classes without loading all of rails.
* spec/requests/records_requests_spec.rb - Integration testing of Rest API RecordController. With this controller specs for API controllers are redundant.

## To run the application locally in development mode
1. Unpackage the zip to a location of your choosing. Navigate into the vinyl folder. 
2. Make sure Ruby 2.4.1 is installed and accessible from the projects root.
3. Install Postgres 9.6.0 or up. Homebrew is usually the easiest way to do this. You can get Homebrew at https://brew.sh.
4. Run 'yarn -v' to see if you have yarn install.
5. Install yarn if you do not. You can run "brew install yarn" or view the installation instructions at https://yarnpkg.com/en/docs/install.
6. Run 'gem install bundler'.
7. Run 'bundle install'.
8. Run 'brew services start postgresql' to start the Postgres database.
9. Run 'rake db:setup'
10. Run 'rails s' to start the Puma.
11. Run 'yarn' to trigger the compilation of the Elm modules. 
12. Run 'bin/webpack-dev-server' to start the Webpack server to run Elm.
13. In a browser, navigate to http://localhost:3000. You should see the index page for records.

## To run the specs
1. Make sure steps 1 - 6 above are complete.
2. Run 'rake db:migrate RAILS_ENV=test'. Just in case it needs to be done for the test database yet.
3. Run 'rspec'.

## Additional Notes
* While I finished a vertical slice of the Elm and Rails REST API architecture, there is still room for improvement. I typically like to refactor my code once or twice but I didn't have time. Admittedly, I underestimated how long the Elm portion was going to take me. I have only experimented in doing simple forms before this. Anyway, I hope you find it interesting.
* Also, in a production app, the Main.elm file can be broken up in to multiple modules to reduce Main.elm's size. 
