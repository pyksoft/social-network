# README

# User Stories


# Database (DB)
## ERD (Entity Relationship Diagram)
![erd database](/docs/images/erd.png)

# DB Tables
I made 5 tables for my app, Account, Profile, Friend, News and Location.
- Account stores the user's email and password.
- Profile stores the user information and references to Photos and Posts.
- Friends stores the user's list of friend accounts
- News stores the user's news feed, likes and location.
- Location stores a list cities, states and countries.

Each account has one profile, one location and a list of friends.
Each profile has many photos and posts.
Each news has one location.
Each friend has one account.

## Account
- email
- password
- Profile (has_one)

## Profile
- first_name
- last_name
- user_id (belongs_to)
- friends_id
- location_id

## Friends
- friend_account_id

## News
- message
- photo
- likes
- profile_id (belongs_to)
- location_id

## Location
- city
- state
- country

# Pages
## homepage
- show own and friends' posts and photos on page
- add post
- add photo
- log in / log out
- register account
- link to friends

## friends
- show list of friends
- add friends
- remove friends

## profile page
- first_name, last_name
- friends count
- photo
- country
- show own posts and photos on page
- edit ability

# Figma (wireframe)