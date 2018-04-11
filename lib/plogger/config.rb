module Plogger
  class Config
    attr_accessor :raven_dsn, :logger, :module

    def initialize(logger)
      @logger = logger
    end
  end
end