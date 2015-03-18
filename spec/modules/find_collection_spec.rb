require 'spec_helper'
require 'digest'

module QuoteMe
  describe FindCollection do 

    class FCKlass 
      include FindCollection
      attr_accessor :attributes
      attr_accessor :fields
    end

    context "FindCollection with a test class" do

      before(:each) do 

        FCKlass.delete_all
        @attributes = double("FieldSet")
        allow(@attributes).to receive(:name) { "A" }
        allow(@attributes).to receive(:covers) {["house", "contents"]}

        @instance = FCKlass.new
        @instance.attributes = @attributes
        @instance.fields = [:name, :covers]
        @instance.after_initialize

      end

      context "FindCollection class methods" do 

        it "should provide a collection via Klass.all" do
          expect(FCKlass.all.class).to eq(Array)
        end

        it "should return an array with 1 object" do
          expect(FCKlass.all.count).to eq(1)
        end

        it "should have @instance as the first item in the array" do 
          expect(FCKlass.all.first).to eq(@instance)
        end

        it "should return fcklasss" do 
          expect(FCKlass.plural_name_from_constant).to eq("fcklasss")
        end

      end

      context "FindCollection instance methods" do 
    
        it "should return a hash of its fields" do 
          expect(@instance.hash).to eq(Digest::SHA1.hexdigest("Ahousecontents"))
        end

      end

    end


  end
end