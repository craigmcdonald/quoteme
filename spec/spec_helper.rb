require_relative '../lib/quote_me'
require_relative 'support/ascending_order_matcher'

QuoteMe.env = 'test'

module QuoteHelpers

  def build_insurers(t)
    t.times.collect do |i| 
      QuoteMe::Insurer.new(
        { name: "Insurer_#{i}", 
          covers: ["house","windows","contents"].first(rand(1..3)) })
    end
  end

  def build_insurer(name,covers)
    name = name || "Insurer1"
    covers = covers || ["house","windows","contents"]
    
    QuoteMe::Insurer.new(name: name, covers: covers)
  end

  def build_rules
    QuoteMe::Rule.new(covers: 2,position: 1, multiply: 0.1)
    QuoteMe::Rule.new(covers: 1,position: 1, multiply: 0.2)
    QuoteMe::Rule.new(covers: 1,position: 2, multiply: 0.25)
    QuoteMe::Rule.new(covers: 1,position: 3, multiply: 0.3)
    QuoteMe::Rule.all
  end
end
