# Plastic Surgery Practice

## Instructions

Our goal for this project is to see:

-	How you understand the task
-	How you integrate with QBO 
-	How fast you can do this task


### Project Specs - Make a simple invoice app

1.	Create a simple two page app
- Page 1 #index -  shows a list of invoices (in the database) - keep the invoice really simple,  one line item
- Page 2 #new  - simple screen to create a new invoice.  don't spend much time on this.  Whatever the simplest screen to be able to create an invoice. 
2.	When you create the invoice it also creates it in QuickBooks Online (create a temporary test/sandbox account for this) 



## Development

### Ruby version

We are using Ruby 3.0.2

### Install bundle:

  bundle install

### Create and migrate your database

Run:

  bundle exec rake db:create db:migrate db:seed

### Run project

In the project directory, you can run:

  bundle exec rails s

Runs the app in the development mode.<br>
Open [http://127.0.0.1:3000](http://127.0.0.1:3000) to view it in the browser.

### Run Rubocop

  bundle exec rubocop

### Run tests

  bundle exec rspec

### Heroku Application

  http://plastic-surgery-development.herokuapp.com/

