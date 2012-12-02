#!/usr/bin/env ruby

require_relative '../lib/blackjack/runner'

runner = Blackjack::Runner.new(ARGV)
runner.run
