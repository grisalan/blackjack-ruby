

module Blackjack

	class PlayerStrategy

		def initialize(strategies)
			@strategies = strategies
		end

		def act(context)
			match = @strategies.keys.find { |k| context =~ k }
			@strategies.fetch(match)
		end

	end

end
