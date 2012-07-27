require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/shoe'

class TestHouseRules < Test::Unit::TestCase
  
  context "initializing a shoe" do
    should "initialize it" do
      shoe = Blackjack::Shoe.new("abcdefgh")
      assert_equal shoe.number_of_cards, 8
      assert_equal shoe.current_position, 1
      assert_equal shoe.next_card, "a"
    end
    should "raise an exception" do
      assert_raises(RuntimeError) {Blackjack::Shoe.new("")}
    end
  end  
  
  context "shuffling a shoe" do
    should "produce a shuffled shoe" do
      shoe = Blackjack::Shoe.new("abcdefgh")
      shoe.shuffle
      assert_equal shoe.number_of_cards, 8
      assert_equal shoe.current_position, 1
      next_cards = ""
      8.times { next_cards << shoe.next_card }
      refute_equal "abcdefgh", next_cards
   	end
  end  
  
end

