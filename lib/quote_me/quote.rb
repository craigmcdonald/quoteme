module QuoteMe

  class Quote

    include FieldSet

    field :user do |user| 
      Recipient.new user
    end
    field :covers
    
    def generate
      insurer_quotes = quotes_from_insurers
      return insurer_quotes unless insurer_quotes.empty?
      return "Sorry no insurers offer the insurance you are requesting"
    end

    private

    def quotes_from_insurers
      @quotes_from_insurers = \
      insurers.collect {|insurer| quote_hash(insurer)}
      .reject {|h| h == nil }
      .sort_by {|h| h.values[1] }
    end

    def quote_hash(insurer)
      {name: insurer.name, quote: calculation.calculate(insurer.covers)} 
    rescue
      nil
    end

    attr_reader :calculation, :insurers

    def after_initialize
      @calculation = Calculation.new(covers)
      @insurers = Insurer.all
    end

  end

end