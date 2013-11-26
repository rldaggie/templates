# Twitter Bootstrap
remove_file 'app/views/layouts/application.html.erb'
get 'https://raw.github.com/rldaggie/templates/master/application.html.erb', 'app/views/layouts/application.html.erb'
remove_file 'app/helpers/application_helper.rb'
get 'https://raw.github.com/rldaggie/templates/master/application_helper.rb', 'app/helpers/application_helper.rb'

# Set app name in en.yml
gsub_file 'config/locales/en.yml', '  hello: "Hello world"', "  app_name: '#{@app_name}'"

# Root controller
generate 'controller', "welcome index"
route "root 'welcome\#index'"

# Devise
gem 'devise'
run 'bundle install'
generate 'devise:install'
generate 'devise:views'
generate 'devise user'
run 'rake db:migrate'

# Add scaffold html
['_form', 'edit', 'index', 'new', 'show'].each do |the_action|
  the_path = "lib/templates/erb/scaffold/#{the_action}.html.erb"
  get "https://raw.github.com/rldaggie/templates/master/#{the_path}", the_path
end
get "https://raw.github.com/rldaggie/templates/master/app/views/shared/_errors.html.erb", 'app/views/shared/_errors.html.erb'