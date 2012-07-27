
require_relative '../logging/logging'

module Blackjack

	class HouseRules
		include Logging

		attr_accessor :stand_on_any_17
		attr_accessor :double_after_split
		attr_accessor :shuffle_point

		def initialize(stand_on_any_17, double_after_split, shuffle_point)
			@stand_on_any_17 = stand_on_any_17
			@double_after_split = double_after_split
			if not (0.0 <= shuffle_point and shuffle_point <= 1.0)
				logger.error("shuffle point out of range")
				raise "shuffle point out of range"
			else
				@shuffle_point = shuffle_point
			end
		end

	end

end
