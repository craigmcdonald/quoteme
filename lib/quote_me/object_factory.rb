module QuoteMe

  class ObjectFactory

    def initialize(params)
      @data = params   
    end

    def build
      fetch.insurers.collect do |params|
       const_get.new(params)
      end
    end

    def fetch
      ValidatedHash.new(File.open(path).read)
    end

    private

    attr_reader :data, :object

    def const_get
      Object.const_get("QuoteMe::"+klass)
    end

    def klass
      data['class'] || data[:class]
    end

    def path
      data['path'] || data[:path]
    end

  end

end