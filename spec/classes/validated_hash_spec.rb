require 'spec_helper'


module QuoteMe
  
  describe ValidatedHash do 

    context "receiving a valid json file" do 

      before(:each) do
        json = File.open('spec/fixtures/request.json').read
        @validated_hash = ValidatedHash.new(json)
      end

      it "should return an instance of ValidatedHash" do 
        expect(@validated_hash.class).to eq(ValidatedHash)
      end

      it "should respond to user" do
        expect(@validated_hash).to respond_to(:user)
      end

    end

    context "receiving an invalid json file" do 

      it "should raise an InvalidRequest error" do 
        json = File.open('spec/fixtures/bad_request.json').read
        expect { ValidatedHash.new(json) }.to raise_error(ValidatedHash::InvalidRequestFormat)
      end

    end

    context "receiving a valid yaml file" do 

       before(:each) do
        yaml = 'spec/fixtures/setup_config_1.yml'
        @validated_hash = ValidatedHash.new(yaml,:yaml)
      end

      it "should respond to user" do
        expect(@validated_hash).to respond_to(:test)
      end
    end


  end

end