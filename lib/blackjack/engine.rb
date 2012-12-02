
require_relative '../logging/logging'
require_relative 'evaluator'
require_relative 'deal_data'


module Blackjack

	class Engine
		include Logging


		def initialize(player_strategy, house_rules)
			@player_strategy = player_strategy
			@house_rules = house_rules
		end


		def next_deal(shoe, startingShoeLocation)

			shoe_cursor = startingShoeLocation - 1

			hands = []
			actions = []
			wagers = []
			payouts = []
			(0..@house_rules.max_hands).each { |i| hands[i] = "" }
			(0...@house_rules.max_hands).each do |i|
				actions[i] = ""
				wagers[i] = 0
				payouts[i] = 0
			end
			hand_position = 1
			next_split_position = 2


			hands[1] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
			hands[0] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
			hands[1] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
			hands[0] << shoe.next_card(shoe_cursor = shoe_cursor + 1)

			if Evaluator.score(hands[0]) == 21
				wagers[0] = @house_rules.base_wager
				if Evaluator.score(hands[1]) == 21
					payouts[0] = @house_rules.base_wager
				else
					payouts[0] = 0
				end
				deal_result(hands, actions, wagers, payouts, shoe_cursor + 1)
			else
				while (hand_position <= @house_rules.max_hands) and (not hands[hand_position] == "")
					if hands[hand_position].length == 1 then hands[hand_position] << shoe.next_card(shoe_cursor = shoe_cursor + 1) end
					context = Evaluator.context(hands[0][0], hands[hand_position], 
						next_split_position, @house_rules.double_after_split, @house_rules.max_hands)
					action = @player_strategy.act(context)
					actions[hand_position - 1] << action

					case action
					when "S"
					when "D"
						hands[hand_position] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
					when "P"
						raise "Trying to split beyond max hand position" if next_split_position > @house_rules.max_hands
						hands[next_split_position] = hands[hand_position][1]
						hands[hand_position] = hands[hand_position][0]
						next_split_position = next_split_position + 1
					when "H"
						isBust = false
						while (action != "S") and (not isBust)
							hands[hand_position] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
							context = Evaluator.context(hands[0][0], hands[hand_position], 
								next_split_position, @house_rules.double_after_split, @house_rules.max_hands)
							isBust = Evaluator.bust?(hands[hand_position])
							if not isBust
								action = @player_strategy.act(context)
								actions[hand_position - 1] << action
							end
						end
					else
						raise "Unexpected drop-through in case(#{action}) in next_deal"
					end

					hand_position = hand_position + 1
				end

				dealer_score = Evaluator.score(hands[0])
				dealer_needs_card = (dealer_score < 17) or 
								(dealer_score == 17 and (not @house_rules.stand_on_17) and Evaluator.soft?(hands[0]))
				while dealer_needs_card
					hands[0] << shoe.next_card(shoe_cursor = shoe_cursor + 1)
					dealer_score = Evaluator.score(hands[0])
					dealer_needs_card = (dealer_score < 17) or 
									(dealer_score == 17 and (not @house_rules.stand_on_17) and Evaluator.soft?(hands[0]))
				end

				(1..@house_rules.max_hands).each do |i|
					if hands[i].length > 0
						player_score = Evaluator.score(hands[i])
						wager = (if Evaluator.doubled?(actions[i - 1]) then 2 * @house_rules.base_wager else @house_rules.base_wager end)
						if player_score == 21 and i == 1 and hands[i].length == 2 and hands[2].length == 0
							wagers[i - 1] = wager
							payouts[i - 1] = (wager * 5) / 2
						elsif player_score > 21
							wagers[i - 1] = wager
							payouts[i - 1] = 0
						elsif dealer_score > 21
							wagers[i - 1] = wager
							payouts[i - 1] = wager * 2
						elsif player_score > dealer_score
							wagers[i - 1] = wager
							payouts[i - 1] = wager * 2
						elsif dealer_score > player_score
							wagers[i - 1] = wager
							payouts[i - 1] = 0
						elsif player_score == dealer_score
							wagers[i - 1] = wager
							payouts[i - 1] = wager
						else
							raise "Flow control problem in next_deal"
						end
					end
				end

				deal_result(hands, actions, wagers, payouts, shoe_cursor + 1)

			end

		end



	private

		def deal_result(hands, actions, wagers, payouts, shoe_location)
			DealData.new(hands, actions, wagers, payouts, shoe_location)
		end

	end

end
