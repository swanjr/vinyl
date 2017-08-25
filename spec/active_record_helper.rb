ENV["RAILS_ENV"] ||= 'test'

require 'spec_helper'

require 'erb'
require 'yaml'
require 'active_record'
require 'shoulda-matchers'
require 'factory_girl'

require 'models/application_record'

db_config = File.new('config/database.yml').read

#Run through ERB to handle the inclusion of ENV variables in the config file
db_config = ERB.new(db_config).result(binding)

connection_info = YAML.load(db_config)['test']
ActiveRecord::Base.establish_connection(connection_info)

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:suite) do
    FactoryGirl.find_definitions if FactoryGirl.factories.count == 0
  end

  # Add transactions without rails
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    
    with.library :active_record
    with.library :active_model
  end
end
