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

# Test
gem 'pg'
gem_group :development, :test do
  gem 'sqlite3'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem "rspec-rails"
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
end

run 'bundle install'
generate 'cucumber:install'
generate 'rspec:install'

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

application do
  "config.action_view.field_error_proc = Proc.new { |html_tag, instance|" 
  "  '<div class=\"has-error\">#{html_tag}</div>'.html_safe"
  "}"
end

# Add scaffold html
['_form', 'edit', 'index', 'new', 'show'].each do |the_action|
  the_path = "lib/templates/erb/scaffold/#{the_action}.html.erb"
  get "#{the_url}#{the_path}", the_path
end
get "#{the_url}app/views/shared/_errors.html.erb", 'app/views/shared/_errors.html.erb'