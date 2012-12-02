

module Blackjack

	class Evaluator

		def self.score(cards)
			ace_present = false
			hand_count = 0
			(0...cards.length).each do |i|
				card = cards[i]
				ace_present = true if card == "A"
				hand_count = hand_count + self.card_count(card)
			end
			if (not ace_present) or (hand_count > 11)
				hand_count
			else
				hand_count + 10
			end
		end

		def self.context(dealer_card, player_cards, next_split_position, double_after_split, max_hands)
			double_possible = "N"
			if ((not next_split_position > 2) or double_after_split) and (player_cards.length == 2)
				double_possible = "Y"
			end
			split_possible = "N"
			if (player_cards.length == 2) and (player_cards[0] == player_cards[1]) and (next_split_position <= max_hands)
				split_possible = "Y"
			end
			"#{self.player_score_str(player_cards)}#{dealer_card}#{double_possible}#{split_possible}"
		end

		def self.result_string(deal_data)
			hands = deal_data.hands
			actions = deal_data.actions
			wagers = deal_data.wagers
			payouts = deal_data.payouts

			result = ""
			(0...hands.length).each do |i|
				result << hands[i]
				result << "," if i < hands.length - 1
			end
			result << ";"
			(0...actions.length).each do |i|
				result << actions[i]
				result << "," if i < actions.length - 1
			end
			result << ";"
			(0...wagers.length).each do |i|
				result << wagers[i].to_s
				result << "," if i < wagers.length - 1
			end
			result << ";"
			(0...payouts.length).each do |i|
				result << payouts[i].to_s
				result << "," if i < payouts.length - 1
			end
			result

		end

		def self.soft?(cards)
			ace_present = false
			hand_count = 0
			(0...cards.length).each do |i|
				card = cards[i]
				ace_present = true if card == "A"
				hand_count = hand_count + self.card_count(card)
			end
			if (not ace_present) or (hand_count > 11)
				false
			else
				true
			end
		end

		def self.doubled?(actions)
			actions.include?("D")
		end

		def self.bust?(cards)
			score(cards) > 21
		end



	private
	
		def self.card_count(card)
			case card
			when "A" then 1
			when "T" then 10
			when "9" then 9
			when "8" then 8
			when "7" then 7
			when "6" then 6
			when "5" then 5
			when "4" then 4
			when "3" then 3
			when "2" then 2
			else
				raise "unexpected case drop through in card_count(#{card})"
			end
		end

		def self.player_score_str(cards)
			ace_present = false
			hand_count = 0
			(0...cards.length).each do |i|
				card = cards[i]
				ace_present = true if card == "A"
				hand_count = hand_count + self.card_count(card)
			end
			if (not ace_present) or (hand_count > 11)
				"#{self.stringified_hand_count(hand_count)}H"
			else
				"#{self.stringified_hand_count(hand_count + 10)}S"
			end
		end

		def self.stringified_hand_count(hand_count)
			if hand_count > 9
				hand_count.to_s
			else
				"0#{hand_count.to_s}"
			end
		end

	end

end
