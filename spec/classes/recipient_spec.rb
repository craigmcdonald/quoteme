module QuoteMe
  
  describe Recipient do

    let(:user) { Recipient.new({ "name"=>"Craig","notify_by"=>"email","notify_to"=>"lefthandcraig@gmail.com"}) }

     it "should have a name" do
      expect(user.name).to eq("Craig")
    end 

    it "should have a notify_by" do
      expect(user.notify_by).to eq("email")
    end

    it "should have a notify_to" do
      expect(user.notify_to).to eq("lefthandcraig@gmail.com")
    end

    it "should not have an age" do
      expect { user.age }.to raise_error
    end

  end

end