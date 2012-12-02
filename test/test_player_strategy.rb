require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/player_strategy'

class TestHouseRules < Test::Unit::TestCase
  
  context "producing actions for blackjack hands" do
    strategies = {/21S.../ => "S", /11HAY./ => "S", /11H[23456789T]YN/ => "D"}
    player_strategy = Blackjack::PlayerStrategy.new(strategies)
    should "stand on blackjack" do
      assert_equal player_strategy.act("21SAYN"), "S"
    end
    should "double on most 11s" do
      assert_equal player_strategy.act("11HAYN"), "S"
      assert_equal player_strategy.act("11HTYN"), "D"
    end
  end  
  
  
end

