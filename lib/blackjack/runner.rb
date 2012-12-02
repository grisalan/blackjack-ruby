
require_relative '../logging/logging'
require_relative 'options'
require_relative 'player_strategy'
require_relative 'shoe'
require_relative 'house_rules'
require_relative 'engine'
require_relative 'blackjack_trial'


module Blackjack

	class Runner
		include Logging


		def initialize(argv)
			@options = Options.new(argv)
		end

		def run
			logger.info("Begin")

			# Set up the shoe
			cards = ""
			File.open(@options.shoe_file).each do |line|
				cards << line.strip
			end
			initial_shoe = Shoe.new(cards)

			# Set up the player strategy
			strategies = {}
			File.open(@options.player_strategy_file).each do |line|
				tokens = line.split(',')
				strategies[Regexp.new(tokens[0].strip)] = tokens[1].strip
			end
			player_strategy = PlayerStrategy.new(strategies)

			# Set up the house rules
			house_rules = HouseRules.new(@options.stand_on_17, @options.double_after_split, 
				@options.shuffle_point, @options.base_wager, @options.max_hands)

			# Set up the engine
			engine = Engine.new(player_strategy, house_rules)

			# Set up the trial
			trial = BlackjackTrial.new("#{@options.number_of_deals}-Hands", engine, initial_shoe, house_rules.shuffle_point, @options.number_of_deals)
			trial.run

			logger.info("End")
		end

	end

end
