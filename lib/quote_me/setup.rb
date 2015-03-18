module QuoteMe

  class Setup

    attr_reader :data

    def initialize(path='lib/config.yml')
      @data = ValidatedHash.new(path,:yaml)
    end

    def make
      data_by_env.keys.each do |obj|
        ObjectFactory.new(data_by_env[obj]).build
      end
    end

    private
    
    def data_by_env
      data[QuoteMe.env]
    end
    
  end


end