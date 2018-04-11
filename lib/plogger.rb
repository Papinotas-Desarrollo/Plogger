require "plogger/version"
require 'plogger/config'
require 'plogger/handler'
require 'logger'

module Plogger
  extend self

  def logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def config
    @@config ||= Plogger::Config.new(logger)
  end

  def configure
    yield(config)
    @@logger = config.logger
    @@config = config
  end

  def exception(exception, type: '', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_exception(exception, category: category, user_id: user_id, account_id: account_id,
                                        extra_info: extra_info)
  end

  def error(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_error(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def warn(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_warning(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def info(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_info(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end

  def debug(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_debug(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info)
  end
end
