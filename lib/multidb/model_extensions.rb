require 'active_record/base'

module Multidb
  module Connection
    def establish_connection(spec = nil)
      super(spec)
      unless ['CommunicationModel', 'CommunicationSplitModel'].include? self.to_s
        Multidb.init(connection_pool.spec.config)
      end
    end

    def connection
      return super if Multidb.model_excluded?(self)
      Multidb.balancer.current_connection
    rescue Multidb::NotInitializedError
      super
    end
  end

  module ModelExtensions
    extend ActiveSupport::Concern

    included do
      class << self
        prepend Multidb::Connection
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include Multidb::ModelExtensions
end
