require 'active_record'
require 'mysql2'
require 'hirb'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
ActiveRecord::Base.establish_connection(ENV['RAILS_ENV'])

ROOT = File.dirname(__FILE__)

Dir[File.join(ROOT, 'app', 'models', '*.rb')].each do |file|
  require file
end

Hirb.enable
