require 'spec_helper'

module QuoteMe

  describe Receiver do

    let(:receiver) { Receiver }

      it "should respond to post" do
        expect(receiver).to respond_to(:post)
      end

      context "a receiver should receive a request" do

        let(:request) {
          File.open('spec/fixtures/request.json').read
       }

      it "should check to see if it can prepare a quote" do 
      
      end

    end

  end
end