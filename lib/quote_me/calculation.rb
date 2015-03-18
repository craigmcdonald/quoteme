module QuoteMe

  class Calculation

    class CoverNotProvidedError < StandardError;end

    attr_reader :covers

    def initialize(covers)
      @covers = covers
    end

    def calculate(covers_offered)
      get_total(covers_offered) * get_multiplier(cover_match(covers_offered)) 
    end

    private

    def get_total(covers_offered)
      covers_offered.inject(0) {|i,cover| i + get_cover_total(cover)}
    end

    def get_cover_total(cover)
      covers[cover] || 0 
    end

    def get_multiplier(count)
      rule_select(count).multiply
    end

    def rule_select(count)  

    # this is effectively hard coding knowledge of what the rules are
    # can I do some string-based meta programming to remove this knowledge?
    # would be pretty cool.

      case count[0]
      when 1
        Rule.all.select {|r| r.covers == count[0] && r.position == count[0]}.first
      when 2
        Rule.all.select {|r| r.covers == count[0]}.first
      end
    end

    def cover_match(covers_offered)
      
      case calc_intersection(covers_offered).count
      when 0
        raise CoverNotProvidedError
      when 1
        [1,position(covers_offered.first)]
      else
        return [2,1]
      end
    end

    def position(cover_offered)
      covers.keys.map(&:to_sym).find_index(cover_offered.to_sym) + 1
    end

    def calc_intersection(covers_offered)
      covers.keys.map(&:to_sym) & covers_offered.map(&:to_sym)
    end

    def sorted_covers
      sorted_by_order.first(cover_count).to_h
    end

    def sorted_by_order
      return sorted_by_value.reverse if sort_order == 'asc'
      return sorted_by_value
    end

    def sorted_by_value
      covers.sort_by { |k,v| v }
    end

    def cover_count
      3
    end

    def sort_order
      'asc'
    end

  end

end