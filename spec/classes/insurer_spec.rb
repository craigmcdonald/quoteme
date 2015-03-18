require 'spec_helper'

module QuoteMe
  describe Insurer do 

    let(:insurer) {
      Insurer.new("name" => "A", "covers" => ["house", "contents"])
    }

    let(:request) {
      File.open('spec/fixtures/request.json').read
    }

    let(:quote) { @quote = Receiver.post(request) }

    let(:data) { quote.covers}

    [:name, :covers].each do |field|
      it "should respond to #{field}" do
        expect(insurer).to respond_to(field)
      end
    end

  end
end