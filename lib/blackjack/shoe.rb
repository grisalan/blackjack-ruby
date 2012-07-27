

module Blackjack

	class Shoe
		include Logging

		def initialize(cards)
			if cards.empty?
				logger.error("Shoe initialized with no cards")
				raise "Shoe initialized with no cards"
			end
			@cards = cards
			@cursor = 0
		end

		def number_of_cards
			@cards.length
		end

		def current_position
			@cursor + 1
		end

		def next_card
			@cursor = @cursor + 1
			@cards[@cursor - 1]
		end

		def shuffle
			(0...@cards.length).each do |index|
				random_position = rand(@cards.length)
				@cards[index], @cards[random_position] = @cards[random_position], @cards[index]
			end
			@cursor = 0
			logger.debug("Shoe shuffled: #{@cards}")
		end

	end

end
