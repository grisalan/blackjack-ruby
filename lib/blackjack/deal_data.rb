
require_relative '../logging/logging'

module Blackjack

	class DealData
		include Logging

		attr_reader :hands
		attr_reader :actions
		attr_reader :wagers
		attr_reader :payouts
		attr_reader :shoe_location

		def initialize(hands, actions, wagers, payouts, shoe_location)
			@hands = hands
			@actions = actions
			@wagers = wagers
			@payouts = payouts
			@shoe_location = shoe_location
		end

	end

end
