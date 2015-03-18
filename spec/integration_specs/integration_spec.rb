require 'spec_helper'

module QuoteMe

  describe 'QuoteMe' do 

    before(:each) do 
      Insurer.delete_all
      Rule.delete_all
    end

    context "the receiver should instantiate a new Quote" do

      let(:request) {
        File.open('spec/fixtures/request.json').read
      }

      before(:each) do
        @quote = Receiver.post(request)
      end

      it "should instantate a new quote" do
        expect(@quote.class).to eq(Quote)
      end

    end

    context "the Quote should compare offers from insurers" do
      let(:insurers) { 
        ObjectFactory.new({class: "Insurer", path: 'spec/fixtures/insurers.json'}).build 
        Insurer.all
      }
      let(:request) {
        File.open('spec/fixtures/request.json').read
      }
      let(:quote) {  @quote = Receiver.post(request) }


      context "the Quote should be sent to the requester" do

      end
    end
  end
end


<<-TEST 

things to test:

* test without rules and insurers set-up
* test with different rules
* test with different insurers
* test with invalid json
* test with invalid yaml
* test with rules json import

things to build:

* folder monitor - https://github.com/guard/listen
* deamonize - https://github.com/thuehlinger/daemons
* emailer - https://github.com/benprew/pony
* sms client - http://www.twilio.com/docs/quickstart/ruby/sms

TEST
