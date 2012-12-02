require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/evaluator'

class TestEvaluator < Test::Unit::TestCase
  
  context "evaluating a score " do
    should "return correct score" do
      assert_equal 21, Blackjack::Evaluator.score("AT")
      assert_equal 12, Blackjack::Evaluator.score("AA")
      assert_equal 15, Blackjack::Evaluator.score("A4T")
      assert_equal 15, Blackjack::Evaluator.score("A4")
      assert_equal 4, Blackjack::Evaluator.score("22")
      assert_equal 20, Blackjack::Evaluator.score("23456")
      assert_equal 15, Blackjack::Evaluator.score("78")
      assert_equal 20, Blackjack::Evaluator.score("A9")
      assert_equal 20, Blackjack::Evaluator.score("AT9")
      assert_equal 23, Blackjack::Evaluator.score("TAT2")
      assert_equal 0, Blackjack::Evaluator.score("")
      assert_equal 55, Blackjack::Evaluator.score("A23456789T")
    end
  end  

  context "evaluating a context" do
    should "return correct context" do
      assert_equal "15S7YN", Blackjack::Evaluator.context("7", "A4", 2, true, 4)


    end
  end

  context "evaluating soft hands" do
    should "return correct soft/hard assessment" do
      assert_equal true, Blackjack::Evaluator.soft?("A42")
      assert_equal false, Blackjack::Evaluator.soft?("A42T")
    end
  end
  
  context "evaluating bust hands" do
    should "return correct bust assessment" do
      assert_equal false, Blackjack::Evaluator.bust?("A42T")
      assert_equal true, Blackjack::Evaluator.bust?("A42T5")
    end
  end
  
  context "evaluating doubled hands" do
    should "return correct doubled assessment" do
      assert_equal false, Blackjack::Evaluator.doubled?("")
      assert_equal false, Blackjack::Evaluator.doubled?("PHHS")
      assert_equal true, Blackjack::Evaluator.doubled?("D")
    end
  end
  
end

