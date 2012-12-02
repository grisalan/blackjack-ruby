require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/house_rules'

class TestHouseRules < Test::Unit::TestCase
  
  context "initializing valid house rules" do
    should "return iniitialized values" do
      rules = Blackjack::HouseRules.new(true, false, 0.76, 10, 4)
      assert_equal rules.stand_on_17, true
      assert_equal rules.double_after_split, false
      assert_equal rules.shuffle_point, 0.76
      assert_equal rules.base_wager, 10
      assert_equal rules.max_hands, 4
   	end
  end  
  
  context "initializing invalid house rules" do
    should "raise an exception" do
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, 1.76, 10, 4)}
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, -0.50, 10, 4)}
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, 0.76, 9, 4)}
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, 0.50, 10.4, 4)}
      assert_raises(RuntimeError) {Blackjack::HouseRules.new(false, true, 1.76, 10, 0)}
   	end
  end  
  
end

