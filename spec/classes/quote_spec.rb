require 'spec_helper'

module QuoteMe

  describe Quote do
    include QuoteHelpers

    let(:quote) { Quote.new(
       {"user"=>
        { "name"=>"Craig",
          "notify_by"=>"email",
          "notify_to"=>"lefthandcraig@gmail.com"},
          "covers"=>{"house"=>50, "contents"=>30, "windows"=>20, "doors" =>10}}
      ) }

    it "should be an instance of Quote" do  
      expect(quote.class).to eq(Quote)
    end

    context "testing the collect method" do

      before(:each) do  
        Insurer.delete_all
        Rule.delete_all
      end

      let(:insurers) { build_insurers(3) }
      let(:rules) { build_rules }

      it "should collect all the quotes" do
        insurers; rules
        expect(quote.generate.count).to eq(3)
      end

      it "should return an array of hashes with insurers Insurers_1..3" do
        insurers; rules 
        expect(quote.generate.collect {|h| h[:name] }).to include("Insurer_0") 
        expect(quote.generate.collect {|h| h[:name] }).to include("Insurer_1")
        expect(quote.generate.collect {|h| h[:name] }).to include("Insurer_2")
        expect(quote.generate.collect {|h| h[:name] }).to_not include("Insurer_z")
      end

      context "testing quote figures" do 

        it "should return one quote hash" do
          build_insurer(nil,["house"])
          rules
          expect(quote.generate.count).to eq(1)
        end

        it "should return the quote hash correctly with a quote of 10" do
          build_insurer(nil,["house"])
          rules 
          expect(quote.generate.first).to include({quote: 10.0})
        end

        it "should return the quote hash correctly with a quote of 7" do
          build_insurer(nil,["house", "windows"])
          rules 
          expect(quote.generate.first).to include({quote: 7.0})
        end

        it "should return the quote hash correctly with a quote of 7" do
          build_insurer(nil,["house", "windows", "cheese"])
          rules 
          expect(quote.generate.first).to include({quote: 7.0})
        end

        it "should return the quote hash correctly with a quote of 7" do
          build_insurer(nil,["house", "cheese"])
          rules 
          expect(quote.generate.first).to include({quote: 10.0})
        end

        it "should return an empty array" do
          build_insurer(nil,["wine", "cheese"])
          rules 
          expect(quote.generate).to include("Sorry no insurers")
        end

     end

    end
  end

end