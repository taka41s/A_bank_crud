
* Ruby version 3.0.0
* Rails version 6.1.4.4

* Postgresql version 12.9
* Database settings
You can check the database settings at config/database.yml

Creating the database
 rails g model User email:string password:digest
 rails db:create
 rails db:migrate
