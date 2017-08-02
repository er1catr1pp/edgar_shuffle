# Edgar Shuffle

This is a small Rails application that mimicks a MeetEdgar account, allowing you to shuffle and un-shuffle content by category and view the resulting queue of upcoming posts.

The app is intended to address the help topic [https://help.meetedgar.com/troubleshooting/how-do-i-un-shuffle-my-posts](https://help.meetedgar.com/troubleshooting/how-do-i-un-shuffle-my-posts) in an automated fashion.


## Demo

A working live demo can be found here: [https://vierless.com/edgar/](https://vierless.com/edgar/)

## Built with: 

- Rails 5
- React
- Bootstrap
- MySQL

## Testing

Testing is implemented via RSpec and Capybara.  

## Deployment

Deployed to AWS via Capistrano

## To run locally

If you would like to run the app locally:

 1. check out the repo
 2. load up the database
```
rake db:migrate
rake db:seed
```
 3. fire up the server

