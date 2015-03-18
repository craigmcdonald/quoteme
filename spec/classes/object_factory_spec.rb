require 'spec_helper'


module QuoteMe
  
  describe ObjectFactory do 

    before(:each) { Insurer.delete_all }

    let(:insurers_factory) { ObjectFactory.new({"class" => "Insurer", "path"=>"spec/fixtures/insurers.json"}) }


    it "should have a path " do
      expect(insurers_factory.send(:path)).to eq('spec/fixtures/insurers.json')
    end 

    it "should return a validated hash from fetch" do 
      expect(insurers_factory.fetch).to be_a(ValidatedHash)
    end

    it "should generate an array of insurers" do 
      expect(insurers_factory.build).to be_a(Array)
    end

    it "should build 3 insurers" do 
      insurers_factory.build
      expect(Insurer.all.count).to eq(3)
    end

  end

end