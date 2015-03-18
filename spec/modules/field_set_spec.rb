require 'spec_helper'

module QuoteMe

  describe "FieldSet" do  

    class FSKlass
      include FieldSet
      field :name
      field :covers
    end

    context "testing FieldSet with a test class" do

      before(:each) do
        @instance = FSKlass.new(name: "Craig", covers: ["a","b"])
      end

      it "should respond to name and covers" do
        expect(@instance).to respond_to(:name)
        expect(@instance).to respond_to(:covers)
      end

    end

  end


end