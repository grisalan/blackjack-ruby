
require_relative '../logging/logging'

module Blackjack

	class Shoe
		include Logging

		def initialize(cards)
			if cards.empty?
				logger.error("Shoe initialized with no cards")
				raise "Shoe initialized with no cards"
			end
			@cards = cards
		end

		def number_of_cards
			@cards.length
		end

		def next_card(shoeLocation)
			raise "#{shoeLocation} out of shoe range" if shoeLocation < 1 || shoeLocation > @cards.length
			@cards[shoeLocation - 1]
		end

		def shuffle
			cards_new = ""
			@cards.chars.each { |c| cards_new << c }
			(0...cards_new.length).each do |index|
				random_position = rand(cards_new.length)
				cards_new[index], cards_new[random_position] = cards_new[random_position], cards_new[index]
			end
			Shoe.new(cards_new)
		end

	end

end
