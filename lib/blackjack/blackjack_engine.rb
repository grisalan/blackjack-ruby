require_relative 'house_rules'

module Blackjack

	class BlackjackEngine

		def initialize(house_rules)
			@house_rules = house_rules

		end

		def next_deal()
			"TT,AT,,,;,,,;10,0,0,0;25,0,0,0"
		end

	end

end