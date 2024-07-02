class ApplicationRecord < ActiveRecord::Base
  require 'sidekiq/api'
  primary_abstract_class
end
