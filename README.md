# What is openweathermapappRoR?

openweathermapRoR is a web application that makes use of the Open Weather Map
API to display today's weather forecast for a specific city. 
  - **Technologies worked with:** Ruby on Rails 7, Tailwind CSS 3, PostgreSQL 14.4
  - **Operating system being used:** Windows 11

# openweathermapappRoR in Action

<img width="239" alt="image" src="https://user-images.githubusercontent.com/26003674/180265528-7cde02d2-ecb5-4497-abe5-cf4af1bebc5b.png">

# Troubleshooting

These are the errors, challenges and problems I faced whilst developing the web
application and how I overcame them. If somebody else is reviewing this repo
and wishes to run or reproduce the application then they may find it helpful
that they can refer to a list of common errors and how to overcome them.

**Problem 1:**  tzinfo-data is not present. Please add gem 'tzinfo-data' to your Gemfile and run bundle install (TZInfo::DataSourceNotFound)

**Solution 1:** Install below gems and edit Gemfile.
  1. gem install tzinfo
  2. gem install tzinfo-data
  3. bundle update
  4. bundle install
  5. Removed ```, platforms: %i[ mingw mswin x64_mingw jruby ]``` from tzinfo-data in gemfile.
  6. https://stackoverflow.com/questions/23033610/ruby-on-rails-server-not-starting
  7. https://stackoverflow.com/questions/54191982/tzinfo-data-issue-when-starting-new-rails-project

**Problem 2:** connection to server at "localhost" (::1), port 5432 failed: Connection refused (0x0000274D/10061) Is the server running on that host and accepting TCP/IP connections? connection to server at "localhost" (127.0.0.1), port 5432 failed: Connection refused (0x0000274D/10061) Is the server running on that host and accepting TCP/IP connections?

**Solution 2:** Install PostgreSQL
  1. https://stackoverflow.com/questions/4482239/postgresql-database-service
  2. https://www.youtube.com/watch?v=GU3uRV0A8HQ&t=65s
  3. Install PostgreSQL from postgres website
  4. Setup path variable in environment variables: Add postgres to path variable.
  5. Open cmd and run psql --version
  6. Run psql -U postgres -W and enter password for user
  7. Run \q to quit postgres terminal
  8. Press Windows key and navigate to Services -> postgreSQL -> Start service

**Problem 3:** connection to server at "localhost" (::1), port 5432 failed: fe_sendauth: no password supplied

**Solution 3:** Removed username and password from config/database.yml and edited pg_hba.conf
  1. https://stackoverflow.com/questions/17996957/fe-sendauth-no-password-supplied
  2. https://stackoverflow.com/questions/40402016/how-to-use-environment-variable-to-avoid-hard-coding-postgresqls-username-and-p
  3. Navigated to openweathermapappRoR -> config -> database.yml
  4. Changed username from 'openweathermapRoR' and removed it all together.
  5. Changed password from '<%= ENV["OPENWEATHERMAPAPPROR_DATABASE_PASSWORD"] %>' and removed it all together.
  6. Navigated to ```C:\Program Files\PostgreSQL\14\data\pg_hba.conf```
  7. Changed method for types 'local' and 'host' from 'scram-sha-256' to 'trust'

**Problem 4:** Server already running on Ruby on Rails

**Solution 4:** Killed process running on port 5432
  1. Run Windows Powershell as administrator
  2. netstat -ano | findstr :5432
  3. taskkill /PID <PID> /F

**Problem 5:** connection to server at "localhost" (::1), port 5432 failed: FATAL: role "willi" does not exist
  
**Solution 5:** Created a new role in postgreSQL with name 'INSERT_DESKTOP_USERNAME'
  1. https://stackoverflow.com/questions/39024056/postgresql-fatal-role-does-not-exist
  2. Run postgreSQL terminal as user postgres and enter command ```create role rolename with createdb login password 'password1';```
  
**Problem 6:** ActiveRecord::NoDatabaseError We could not find your database: openweathermapappRoR_development. Which can be found in the database configuration file located at config/database.yml.
  
**Solution 6:** Add ability to create databases to role created in step 5
  1. ALTER USER user1 CREATEDB;
  2. bundle exec rails db:create

**Checkpoint:** I now finally had my rails server up and running okay!
  
**Problem 7:** Went to Open Weather Map website and registered as a new user to get an API key but the API key didn't work immediately.

**Solution 7:** Wait one hour for API key to be active
  
**Problem 8:** Entered latitude and longitude of my current location but it showed up as somewhere else.

**Solution 8:** Needed a minus sign before the longitude as it is common convention that positive numbers represent East (Longitude) and North (Latitude) wheras negative numbers represent West (Longitude) and South (Latitude).
  
**Problem 9:** Errno::EACCES in Home#index
  
**Solution 9:** Navigated to openweathermapappRoR -> config -> routes.rb and added the following lines
  1. https://guides.rubyonrails.org/getting_started.html -> Section 4.2
  2. get "/home", to: "home#index"
  3. root "home#index"

**Problem 10:** Unkown at rules @tailwind

**Solution 10:** In VSCode Ctrl + ',' -> type 'css' -> Search for Lint: Unknown at rules -> Click ignore from drop-down menu
  1. https://stackoverflow.com/questions/47607602/how-to-add-a-tailwind-css-rule-to-css-checker

**Problem 11:** Sprockets::Rails::Helper::AssetNotFound in Home#index. The asset "tailwind.css" is not present in the asset pipeline.

**Solution 11:** Ran tailwind command in cmd, closed and reopened VSCode, restarted rails server and server was running fine with tailwind styles in place.
  1. https://guides.rubyonrails.org/asset_pipeline.html
  2. https://stackoverflow.com/questions/71640507/how-to-import-tailwind-plugin-in-rails-7
  3. Entered following command in cmd, ```tailwind -i 'app\assets\stylesheets\application.tailwind.css' -o 'app\assets\builds\tailwind.css' -c 'config\tailwind.config.js' --minify```
  4. In terminal ```bundle exec rails assets:clean assets:precompile```
  5. Navigate to openweathermapRoR -> config -> environments -> development.rb and add 'config.assets.prefix = "/dev-assets"'
  6. Navigated to openweathermapRoR -> Gemfile and changed 'gem "tailwind-rails", "~> 2.0"' to 'gem tailwind-rails'
  7. Closed VSCode and Reopened it
  8. Restarted rails server with ```bundle exec rails s```
  9. Everything working fine!
  
**Problem 12:** Connecting rails project to GitHub repo

**Solution 12:** https://www.youtube.com/watch?v=ZmA0VE2Lj2U

# What I've Learned
  
This section details my learning outcomes from troubleshooting and coding, interesting findings from researching the problem and any new domain knowledge gained.

  - **Troubleshooting:** This depends on many factors like the type of machine you have, what operating system you are using, which versions of software you are using, in your projects and your configuration settings. The best advice is to use the most up-to-date software as that will have the best resources for finding and resolving errors in the documentation and on stackoverflow. I also learned that it is helpful to breakup large errors into smaller ones by finding sub-problems in problems. As you can see, even for a web application as small and simple as openweathermapRoR, there were many errors and challenges overcome. Another thing to note is that, for this reason, you cannot underestimate how long a project is going to take because you can run into many unexpected, unforeseen and inocuous errors that can hamper and slow down your development process.
  - **Domain Knowledge:** Learned that common convntion for latitude and longitude is that positive numbers represent East (Longitude) and North (Latitude) wheras negative numbers represent West (Longitude) and South (Latitude). 
  - **Coding:** Learned how to get a Ruby on Rails server up and running, how to generate controllers in the terminal, how to incorporate an API in a web application, how to setup postgres and tailwind with rails 7, how to resolve errors involving rails server setup and tailwind styling.
  - **Research:** Learned that Open Weather Map API keys are active after at least one hour has passed.
  
# How to run the Application
  
  1. Clone the repository on your machine
  2. Install Ruby
  3. Install Ruby on Rails
  4. Run ```bundle install``` in the terminal to install all dependencies
  5. Run ```bundle exec rails s``` to start the server and see what errors you get
  6. Make reference to the troubleshooting section of this readme to resolve any errors that come up.
