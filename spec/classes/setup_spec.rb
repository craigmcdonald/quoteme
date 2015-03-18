require 'spec_helper'

module QuoteMe

  describe Setup do 

    before(:each) {
      Insurer.delete_all
    }

    let(:setup) { QuoteMe::Setup.new('spec/fixtures/setup_config_1.yml') }

    it "should take a path to a YAML file and load this path into a Hashie::Mash" do
      expect(setup.data).to be_a(Hashie::Mash)
    end

    it "should respond to make" do
      expect(setup).to respond_to(:make)
    end

    it "should create three insurers" do 
      setup.make
      expect(Insurer.all.count).to eq(3)
    end


  end

end