
require_relative '../logging/logging'

module Blackjack

	class BlackjackTrial
		include Logging

		attr_reader :trial_name
		attr_reader :engine
		attr_reader :initial_shoe
		attr_reader :shuffle_point
		attr_reader :number_of_deals

		def initialize(trial_name, engine, initial_shoe, shuffle_point, number_of_deals)
			@trial_name = trial_name
			@engine = engine
			@initial_shoe = initial_shoe
			@shuffle_point = shuffle_point
			@number_of_deals = number_of_deals
		end

		def run()
			shoe = @initial_shoe.shuffle()
			shoe_location = 1
			(1..@number_of_deals).each do |n|
				deal_result = @engine.next_deal(shoe, shoe_location)
				process_engine_result(deal_result, n)
				shoe_location = deal_result.shoe_location
				if (shoe_location - 0.0) / shoe.number_of_cards >= @shuffle_point
					shoe = shoe.shuffle()
					shoe_location = 1
				end
			end
		end

		private

		def process_engine_result(deal_result, deal_number)
			result = Blackjack::Evaluator.result_string(deal_result)
			puts "#{@trial_name}=>#{deal_number}:#{result}"
		end

	end


end
