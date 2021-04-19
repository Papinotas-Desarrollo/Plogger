module Plogger
  class Config
    attr_accessor :logger, :module

    def initialize(logger)
      @logger = logger
    end
  end
end
