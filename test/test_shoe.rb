require 'test/unit'
require 'shoulda'
require_relative '../lib/blackjack/shoe'

class TestShoe < Test::Unit::TestCase
  
  context "initializing a shoe" do
    should "initialize it" do
      shoe = Blackjack::Shoe.new("abcdefgh")
      assert_equal 8, shoe.number_of_cards
      assert_equal "a", shoe.next_card(1)
      assert_equal "d", shoe.next_card(4)
      assert_raises(RuntimeError) {shoe.next_card(0)}
      assert_raises(RuntimeError) {shoe.next_card(9)}
    end
    should "raise an exception" do
      assert_raises(RuntimeError) {Blackjack::Shoe.new("")}
    end
  end  
  
  context "shuffling a shoe" do
    should "produce a new shuffled shoe" do
      shoe = Blackjack::Shoe.new("abcdefgh")
      shoe_new = shoe.shuffle
      assert_equal 8, shoe.number_of_cards
      assert_equal 8, shoe_new.number_of_cards
      old_cards = ""
      (1..8).each { |n| old_cards << shoe.next_card(n) }
      assert_equal "abcdefgh", old_cards
      new_cards = "" 
      (1..8).each { |n| new_cards << shoe_new.next_card(n) }
      refute_equal "abcdefgh", new_cards
      assert_raises(RuntimeError) {shoe_new.next_card(0)}
      assert_raises(RuntimeError) {shoe_new.next_card(9)}
   	end
  end  
  
end

