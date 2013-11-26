# Twitter Bootstrap
remove_file 'app/views/layouts/application.html.erb'
get 'https://raw.github.com/rldaggie/templates/master/application.html.erb', 'app/views/layouts/application.html.erb'


# Root controller
generate 'controller', "welcome index"
route "root 'welcome\#index'"

# Devise
if yes? "Devise?"
  gem 'devise'
  run 'bundle install'
  generate 'devise:install'
  generate 'devise:views'
  generate 'devise user'
  run 'rake db:migrate'
end