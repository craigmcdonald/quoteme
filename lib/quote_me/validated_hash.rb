module QuoteMe

  class ValidatedHash

    def initialize(request)
      @data = Hashie::Mash.new(JSON.parse(request))
    rescue
      raise InvalidRequestFormat
    end

    def method_missing(method,*a,&b)
      data.send(method,*a,&b)
    end

    def respond_to?(method)
      data.respond_to?(method)
    end

    private 

    attr_accessor :data    

    class InvalidRequestFormat < StandardError; end

  end
end