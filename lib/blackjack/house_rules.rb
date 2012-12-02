
require_relative '../logging/logging'

module Blackjack

	class HouseRules
		include Logging

		attr_reader :stand_on_17
		attr_reader :double_after_split
		attr_reader :shuffle_point
		attr_reader :base_wager
		attr_reader :max_hands

		def initialize(stand_on_17, double_after_split, shuffle_point, base_wager, max_hands)
			@stand_on_17 = stand_on_17
			@double_after_split = double_after_split
			if not (0.0 <= shuffle_point and shuffle_point <= 1.0)
				logger.error("shuffle point out of range")
				raise "shuffle point out of range"
			else
				@shuffle_point = shuffle_point
			end
			if (base_wager % 2 != 0)
				logger.error("base wager is not an even number")
				raise "base wager is not an even number"
			else
				@base_wager = base_wager
			end
			if (max_hands < 1)
				logger.error("max hands < 1")
				raise "max hands < 1"
			else
				@max_hands = max_hands
			end
		end

	end

end
