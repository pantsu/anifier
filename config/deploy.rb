require 'bundler/capistrano'
require "rvm/capistrano"
require 'thinking_sphinx/deploy/capistrano'

set :application, "anifier"
set :repository,  "git@github.com:railsrumble/r12-team-527.git"

set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :user, "anifier"
set :use_sudo, false
set :rvm_type, :system
set :rvm_ruby_string, 'default@anifier'

role :web, "198.74.58.246"                          # Your HTTP server, Apache/etc
role :app, "198.74.58.246"                          # This may be the same as your `Web` server
role :db,  "198.74.58.246", :primary => true # This is where Rails migrations will run

namespace :deploy do
  %w(start stop restart up down).each do |action|
    desc "#{action.capitalize} unicorns for application"
    task action.to_sym, :roles => :app, :except => { :no_release => true } do
      run "echo #{action} > /etc/sv/anifier/supervise/control"
    end
  end

  desc "Symlink config files from shared directory to current release directory."
  task :symlink_configs do
    run "ln -nsf #{shared_path}/config/unicorn/production.rb #{current_release}/config/unicorn_production.rb"
    run "ln -nsf #{shared_path}/config/database.yml #{current_release}/config/"
    %w(smtp).each do |initializer|
      run "ln -nsf #{shared_path}/config/initializers/#{initializer}.rb #{current_release}/config/initializers/"
    end
  end

  desc "Symlink file cache to current release directory"
  task :symlink_cache, :roles => :app do
    run "ln -nsf #{shared_path}/cache #{current_release}/tmp/cache"
  end
end

after "deploy:update_code", "deploy:symlink_configs"
after "deploy:update_code", "thinking_sphinx:configure"
# after "deploy:update_code", "deploy:symlink_cache"
after "deploy", "deploy:cleanup"
after "deploy", "thinking_sphinx:rebuild"
