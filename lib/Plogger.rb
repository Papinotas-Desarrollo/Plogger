require "Plogger/version"
require 'Plogger/config'
require 'Plogger/handler'
require 'logger'

module Plogger
  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.config
    @@config ||= Plogger::Config.new(logger)
  end

  def self.configure
    yield(config)
    @@logger = config.logger
    @@config = config
  end

  def self.exception(exception, category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_exception(exception, category: category, user_id: user_id, account_id: account_id,
                                        extra_info: extra_info)
  end

  def self.error(message, category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_error(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def self.warn(message, category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_warning(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def self.info(message, category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_info(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def self.debug(message, category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_debug(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end
end
