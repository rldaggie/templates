generate :controller, "welcome index"
route "root to: 'welcome\#index'"

if yes? "Devise?"
  gem 'devise'
  run 'bundle install'
  generate 'devise:install'
  generate 'devise:views'
  generate 'devise user'
  run 'rake db:migrate'
end