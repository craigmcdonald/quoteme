require 'spec_helper'
require 'json'

module QuoteMe
  describe Insurer do 

    context "instances of Insurer class" do 

      after(:each) {
        Insurer.delete_all
      }

      let(:insurer) {
        Insurer.new("name" => "A", "covers" => ["house", "contents"])
      }

      let(:request) {
        File.open('spec/fixtures/request.json').read
      }

      let(:request) {
        JSON.generate(
          {"user"=>
        { "name"=>"Craig",
          "notify_by"=>"email",
          "notify_to"=>"lefthandcraig@gmail.com"},
          "covers"=>{"house"=>50, "contents"=>30, "windows"=>20}}
          )
      }

      let(:quote) { 

        @quote = Receiver.post(request) 

      }

      let(:data) { quote.covers}

      [:name, :covers].each do |field|
        it "should respond to #{field}" do
          expect(insurer).to respond_to(field)
        end
      end

      it "should respond to all" do 
        expect(Insurer).to respond_to(:all)
      end

    end
  end
end