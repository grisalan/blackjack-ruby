require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/options'

class TestOptions < Test::Unit::TestCase
  
  context "specifying no player strategy file" do
    should "return default" do
      opts = Blackjack::Options.new(["50"])
      assert_equal Blackjack::Options::DEFAULT_PLAYER_STRATEGY_FILE, opts.player_strategy_file
      assert_equal ["50"], opts.number_of_deals
    end
  end  

  context "specifying a player strategy file" do
    should "return it" do    
      opts = Blackjack::Options.new(["-p", "myfile", "100"])
      assert_equal "myfile", opts.player_strategy_file
      assert_equal ["100"], opts.number_of_deals
    end
  end      
  
  context "specifying the mother lode" do
    should "return it" do    
      opts = Blackjack::Options.new(["-p", "myfile", "-s", "theShoe", "-a", "-d", "-f", "0.5", "103"])
      assert_equal "myfile", opts.player_strategy_file
      assert_equal "theShoe", opts.shoe_file
      assert_equal true, opts.stand_on_any_17
      assert_equal true, opts.double_after_split
      assert_equal 0.5, opts.shuffle_point
      assert_equal ["103"], opts.number_of_deals
    end
  end      
  
end
