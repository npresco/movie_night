# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Dir.glob("app/lib/tasks/*.rake").each { |r| import r }

Rails.application.load_tasks
