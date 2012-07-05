
Setup
-----

1. Make sure you have all the dependencies:
   from a terminal run the following commands:
     1. `curl -L https://get.rvm.io | bash -s stable --ruby`
     2. `rvm install 1.9.2`
     3. `gem install bundler`
     4. `bundle install`

2. From inside the project directory run `redcar` and edit 'db/config.yml' to add the following:

    voegele:
      <<: *common
      user: root
      password: password
      database: colombia
      host: localhost

   where username and password are your username and password to the mysql db. any of these
   options can be ommited if their default values (the shown values) are sufficient. If you
   don't need to change any of the default values, then don't add a new section and use
   'development' in step 3.

3. Running the application:

   in a terminal from inside the project directory, run:

   `RAILS_ENV=voegele ./fill_long_lat.rb (google|osm)`

   where voegele is the name of the section you added in step 2.

   if you're running on mac, use this command instead:

   `DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH RAILS_ENV=voegele ./fill_long_lat.rb (google|osm)`

4. Changing the table name

   from the project directory, run `redcar` and edit `app/models/corrected_addresses.rb` and change `corrected_addresses`
   to the new table name.

Links
-----
  - [Nominatim Documentation](http://wiki.openstreetmap.org/wiki/Search)
