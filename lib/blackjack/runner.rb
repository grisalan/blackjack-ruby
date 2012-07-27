
require_relative 'options'
require_relative 'blackjack_engine'


module Blackjack

	class Runner

		def initialize(argv)
			@options = Blackjack::Options.new(argv)
		end

		def run
			house_rules = HouseRules.new(@options.stand_on_any_17, @options.double_after_split, @options.shuffle_point)
			engine = Blackjack::BlackjackEngine.new(house_rules)
			puts engine.next_deal
		end

	end

end
