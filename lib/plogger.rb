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

  def exception(exception, type: 'system', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_exception(exception, category: category, user_id: user_id, account_id: account_id,
                                        extra_info: extra_info.merge({log_severity: 'exception'}))
  end

  def error(message, type: 'system', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_error(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info.merge({log_severity: 'error'}))
  end

  def warn(message, type: 'system', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_warning(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info.merge({log_severity: 'warn'}))
  end

  def info(message, type: 'system', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_info(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info.merge({log_severity: 'info'}))
  end

  def debug(message, type: 'system', category: '', user_id: '', account_id: '', extra_info: {})
    handler = Plogger::Handler.new(config)
    handler.handle_debug(message, category: category, user_id: user_id, account_id: account_id,
                                  extra_info: extra_info.merge({log_severity: 'debug'}))
  end
end
