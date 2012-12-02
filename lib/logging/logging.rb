require 'logger'


module Logging
  def logger
    @logger ||= Logging.logger_for(self.class.name)
  end

  # Use a hash class-ivar to cache a unique Logger per class:
  @loggers = {}

  class << self
    def logger_for(classname)
      @loggers[classname] ||= configure_logger_for(classname)
    end

    def configure_logger_for(classname)
      logger = Logger.new('blackjack.log')
      logger.level = Logger::DEBUG
      logger.progname = classname
      logger.datetime_format = "%Y-%m-%d %H:%M:%S"
      logger
    end
  end
end


=begin
	
incorporate into Logging module

@out = STDOUT 
#(as module variable) and this as a class method: 
def configure(config) 
	logout = config['logout'] 
	if logout != 'STDOUT' then @out = logout # should be a log path, like /tmp/log.txt 
	end 
end 
	
=end