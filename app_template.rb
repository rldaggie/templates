the_url = "https://raw.github.com/rldaggie/templates/master/"

# Twitter Bootstrap
remove_file 'app/views/layouts/application.html.erb'
get "#{the_url}app/views/layouts/application.html.erb", 'app/views/layouts/application.html.erb'
remove_file 'app/helpers/application_helper.rb'
get "#{the_url}app/helpers/application_helper.rb", 'app/helpers/application_helper.rb'

# Set app name in en.yml
gsub_file 'config/locales/en.yml', '  hello: "Hello world"', "  app_name: '#{@app_name}'"

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

  # Change Devise Views
  ['passwords/new', 'passwords/edit', 'registrations/new', 'registrations/edit', 'sessions/new', 'shared/_links'].each do |the_devise|
    the_path = "app/views/devise/#{the_devise}.html.erb"
    remove_file the_path
    get "#{the_url}#{the_path}", the_path
  end
end

# Add scaffold html
['_form', 'edit', 'index', 'new', 'show'].each do |the_action|
  the_path = "lib/templates/erb/scaffold/#{the_action}.html.erb"
  get "#{the_url}#{the_path}", the_path
end
get "#{the_url}app/views/shared/_errors.html.erb", 'app/views/shared/_errors.html.erb'