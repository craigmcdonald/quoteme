RSpec::Matchers.define :be_in_ascending_order do 
  match do |actual|
    actual.sort == actual
  end
end