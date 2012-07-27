require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/house_rules'

class TestHouseRules < Test::Unit::TestCase
  
  context "initializing a house strategy" do
    should "return iniitialized values" do
      rules = Blackjack::HouseRules.new(true, false, 0.76)
      assert_equal rules.stand_on_any_17, true
      assert_equal rules.double_after_split, false
      assert_equal rules.shuffle_point, 0.76
   	end
  end  
  
  context "initializing a house strategy with bad shuffle point" do
    should "raise an exception on bad shuffle points" do
      rules = Blackjack::HouseRules.new(true, false, 0.0)
      Blackjack::HouseRules.new(false, true, 1.0)
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, 1.76)}
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, -0.50)}
   	end
  end  
  
end

