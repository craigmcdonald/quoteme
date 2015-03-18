require 'spec_helper'

module QuoteMe

  class InnerClass
    include FieldSet
    field :name
    def initialize(params)
      super
    end
  end

  module FieldSet
    describe FieldSet do 

      context "given params of 'hello' and 'goodbye'" do

        it "should create instance methods 'hello' and 'goodbye'" do
          sample = FieldSet.new({"hello" => "hi", "goodbye" => 'bye'},[{name: :hello, block: nil}, {name: :goodbye, block: nil}])
          expect(sample).to respond_to(:hello)
          expect(sample).to respond_to(:goodbye)
        end
      end

      context "given a param 'goodbye' which is to be turned into an object of a given Class" do

        let(:sample) {
          block = Proc.new { |goodbye| InnerClass.new(goodbye) }
          FieldSet.new({hello: "hi", goodbye: {name: "Steve"}},[{name: :hello, block: nil}, {name: :goodbye, block: block}])
        }

        it "should return an object of that class for method 'goodbye'" do    
          expect(sample.goodbye.class).to eq(InnerClass)
        end

        context "the object returned from the method 'goodbye' responds to name" do  

          it "should return 'Steve' " do  
            expect(sample.goodbye.name).to eq("Steve")
          end

        end

      end
    end
  end
end