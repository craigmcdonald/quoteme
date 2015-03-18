module QuoteMe

  class ValidatedHash

    # make this support different file formats

    def initialize(request,format=:json)
      @data = Hashie::Mash.new(fetch_by_format(request,format))
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

    def fetch_by_format(request,format)
      case format
      when :json
        fetch_json(request)
      when :yaml
        fetch_yaml(request)
      end
    end   

    def fetch_json(request)
      JSON.parse(request)
    end

    def fetch_yaml(request)
      YAML::load_file(request)
    end

    class InvalidRequestFormat < StandardError; end

  end
end