# 5xTraining
This is a To-do list system for 5xruby-training.
## Getting Started
* Ruby version: 2.6.5
* Rails version: 6.0.2.1
* Clone this project
* `$ bundle install`
* `$ rails db:create`
* `$ rails db:migrate`
* `$ rails server` 
* Basic auth account: 5xtraing
* Basic auth password: happycoding

## Website deploy
This project is deployed on heroku.
* `$ heroku create my5xtraining`
* `$ git remote -v` to check remote heroku
	* heroku  https://git.heroku.com/my5xtraining.git (fetch)
	* heroku  https://git.heroku.com/my5xtraining.git (push)
* `git push heroku master:master`
* `heroku run rails db:setup`
* Setup ENV_variable in Reveal Config Vars

## Table Schema

| User     |        |
| -------- | ------ |
| id       | Text   |
| name     | string |
| email    | string |
| password | string |



| Task     |                                   |
| -------- | --------------------------------- |
| title    | string                            |
| content  | text                            |
| status   | enum{ pending, processing, done } |
| priority | enum{ high, normal, low }         |
| start_at | time_stamp                        |
| end_at   | time_stamp                        |


| Tag  |        |
| ---- | ------ |
| name | string |


| TaskTag |         |
| ------- | ------- |
| task_id | integer |
| tag_id  | integer |