#---
# Excerpted from "Programming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby3 for more book information.
#---
require 'optparse'

module Blackjack
  class Options
     
    DEFAULT_PLAYER_STRATEGY_FILE = "PlayerStrategyBasic.txt"
    DEFAULT_SHOE_FILE = "SixDeck.txt"
    DEFAULT_STAND_ON_17 = false
    DEFAULT_DOUBLE_AFTER_SPLIT = false
    DEFAULT_SHUFFLE_POINT = 0.5
    DEFAULT_BASE_WAGER = 10
    DEFAULT_MAX_HANDS = 4
    
    attr_reader :player_strategy_file
    attr_reader :shoe_file
    attr_reader :stand_on_17
    attr_reader :double_after_split
    attr_reader :shuffle_point
    attr_reader :base_wager
    attr_reader :max_hands
    attr_reader :number_of_deals

    def initialize(argv)
      @player_strategy_file = DEFAULT_PLAYER_STRATEGY_FILE
      @shoe_file = DEFAULT_SHOE_FILE
      @stand_on_17 = DEFAULT_STAND_ON_17
      @double_after_split = DEFAULT_DOUBLE_AFTER_SPLIT
      @shuffle_point = DEFAULT_SHUFFLE_POINT
      @base_wager = DEFAULT_BASE_WAGER
      @max_hands = DEFAULT_MAX_HANDS
      parse(argv)
      @number_of_deals = argv[0].to_i
    end
                 
  private
    
    def parse(argv)
      OptionParser.new do |opts|  
        opts.banner = "Usage:  blackjack [ options ]  numberOfDeals"

        opts.on("-p", "--player-strategy [filepath]", String, "Optional path to player strategy file") do |ps_file|
          @player_strategy_file = ps_file
        end 

        opts.on("-s", "--shoe [filepath]", String, "Optional path to shoe file") do |sh_file|
          @shoe_file = sh_file
        end 

        opts.on("-a", "--[no-]stand-on-17", "[no-] stand on any 17 flag") do 
          @stand_on_17 = true
        end 

        opts.on("-d", "--[no-]double-after-split", "[no-] double after split flag") do 
          @double_after_split = true
        end 

        opts.on("-f", "--shuffle-point [n]", Float, "Shuffle point - 0.0 to 1.0") do |sp|
          unless 0.0 <= sp && sp <= 1.0
            raise ArgumentError, "Shuffle point must be between 0.0 and 1.0 inclusive"
          end
          @shuffle_point = sp
        end 

        opts.on("-m", "--max-hands [n]", Integer, "Maximum hands to play (on splits) >= 1") do |mh|
          unless mh >= 1
            raise ArgumentError, "Max hands must be one or greater"
          end
          @max_hands = mh
        end 

        opts.on("-w", "--base-wager [n]", Integer, "Base wager - must be an even number") do |bw|
          unless bw % 2 == 0
            raise ArgumentError, "Base wager must be an even number"
          end
          @base_wager = bw
        end 

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        begin
          argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end    
    end
  end
end
