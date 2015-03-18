require 'spec_helper'

module QuoteMe

  describe Calculation do 

    let(:calculation) do 
      Calculation.new( {doors: 10, house: 50,contents: 30, windows: 20} )
    end

    let(:insurer) do 
      insurer = double("Insurer")
      allow(insurer).to receive(:name) { "A"}
      allow(insurer).to receive(:covers) { [:house] }
      insurer
    end

    let(:rules) do 
      Rule.new(covers: 2,position: 1,multiply: 0.1)
      Rule.new(covers: 1,position: 1,multiply: 0.2)      
      Rule.new(covers: 1,position: 2,multiply: 0.25)  
      Rule.new(covers: 1,position: 1,multiply: 0.3)
      Rule.all      
    end


    it "should respond to covers" do 
      expect(calculation.covers).to eq({doors: 10, house: 50,contents: 30, windows: 20})
    end

    it "should return the 3 most expensive covers in a sorted array" do
      expect(calculation.send(:sorted_covers)).to eq({house: 50,contents: 30, windows: 20})
    end

    it "should take an array of covers offered and return the cost of the quote" do
      rules
      expect(calculation.calculate(insurer.covers)).to eq(10)
    end

  end

end