require 'spec_helper'

module QuoteMe

  describe Rule do 

    before(:each) {Rule.delete_all}

    let(:rule) { Rule.new(
                  covers: 1,
                  position: 1,
                  multiply: 0.2)
    }


    it "should respond to covers, position, and multiply" do
      expect(rule).to respond_to(:covers)
      expect(rule).to respond_to(:position)
      expect(rule).to respond_to(:multiply)
    end

    it "should return 1 for covers" do
      expect(rule.covers).to eq(1)
    end

    it "should return 1 for position" do
      expect(rule.position).to eq(1)
    end

    it "should return 0.2 for multiply" do 
      expect(rule.multiply).to eq(0.2)
    end

    it "should have created 1 rule" do
      rule 
      expect(Rule.all.count).to eq(1)
    end

  end

end