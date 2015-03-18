require 'pry'
require 'json'
require 'hashie'
require 'yaml'

module QuoteMe

  class << self

    def env
      Thread.current[:quote_me_env] || 'development'
    end

    def env=(env)
      Thread.current[:quote_me_env] = env
    end

  end

  class Receiver

    class << self
      
      def post(request)
        Quote.new(ValidatedHash.new(request))
      end

    end

  end

end

require_relative 'quote_me/setup'
require_relative 'quote_me/validated_hash'
require_relative 'quote_me/field_set'
require_relative 'quote_me/find_collection'
require_relative 'quote_me/object_factory'
require_relative 'quote_me/insurer'
require_relative 'quote_me/recipient'
require_relative 'quote_me/quote'
require_relative 'quote_me/calculation'
require_relative 'quote_me/rule'