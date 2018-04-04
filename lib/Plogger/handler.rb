require 'Plogger/id_generator'
require 'Plogger/formatter'

module Plogger
  class Handler
    def initialize(config)
      @logger = config.logger
      @module = config.module
      @raven_dsn = config.raven_dsn
    end

    def handle_exception(exception, category: '', user_id: nil, account_id: nil, extra_info: {})
      unless @raven_dsn == nil || @raven_dsn.blank?
        Raven.user_context(id: user_id)
        Raven.tags_context(account_id: account_id)
        Raven.capture_exception(exception)
      end
      handle_error(exception.message, category: category, user_id: user_id, account_id: account_id,
                                      extra_info: extra_info)
    end

    def handle_error(message, category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id,
                                                extra_info: generate_extra_info(extra_info))
      @logger.error(result[:message])
      result[:trace]
    end

    def handle_warning(message, category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id,
                                                extra_info: generate_extra_info(extra_info))
      @logger.warn(result[:message])
      result[:trace]
    end

    def handle_info(message, category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id,
                                                extra_info: generate_extra_info(extra_info))
      @logger.info(result[:message])
      result[:trace]
    end

    def handle_debug(message, category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id,
                                                extra_info: generate_extra_info(extra_info))
      @logger.debug(result[:message])
      result[:trace]
    end

    private

    def generate_id_and_message(message, category: '', user_id: '', account_id: '', extra_info: {})
      trace = Plogger::IdGenerator.generate
      formatted_message = Plogger::Formatter.format(message, trace, user_id: user_id,
                                                                    account_id: account_id,
                                                                    category: category,
                                                                    extra_info: extra_info)
      {trace: trace, message: formatted_message}
    end

    def generate_extra_info extra_info
      extra_info.merge({module: @module})
    end
  end
end