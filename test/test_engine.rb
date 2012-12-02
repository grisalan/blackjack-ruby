require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/engine'
require_relative '../lib/blackjack/player_strategy'
require_relative '../lib/blackjack/house_rules'
require_relative '../lib/blackjack/shoe'
require_relative '../lib/blackjack/evaluator'

class TestEngine < Test::Unit::TestCase
  
  player_strategy = Blackjack::PlayerStrategy.new({/2...../ => "S"})

  context "returning the next deal with T/T/0.8 house rules" do
    house_rules = Blackjack::HouseRules.new(true, true, 0.8, 10, 4)
    should "return correct result" do
      shoe = Blackjack::Shoe.new("AATTTTTTTTTT")
      engine = Blackjack::Engine.new(player_strategy, house_rules)
      assert_equal "AT,AT,,,;,,,;10,0,0,0;10,0,0,0", Blackjack::Evaluator.result_string(engine.next_deal(shoe, 1))
      shoe = Blackjack::Shoe.new("TATTTTTTTTTTT")
      engine = Blackjack::Engine.new(player_strategy, house_rules)
      assert_equal "AT,TT,,,;,,,;10,0,0,0;0,0,0,0", Blackjack::Evaluator.result_string(engine.next_deal(shoe, 1))
      shoe = Blackjack::Shoe.new("T4T8TTTTTTTTTT")
      engine = Blackjack::Engine.new(player_strategy, house_rules)
      assert_equal "48T,TT,,,;S,,,;10,0,0,0;20,0,0,0", Blackjack::Evaluator.result_string(engine.next_deal(shoe, 1))
      shoe = Blackjack::Shoe.new("T4T89TTTTTTTTTT")
      engine = Blackjack::Engine.new(player_strategy, house_rules)
      assert_equal "489,TT,,,;S,,,;10,0,0,0;0,0,0,0", Blackjack::Evaluator.result_string(engine.next_deal(shoe, 1))
    end
  end  

 
end

