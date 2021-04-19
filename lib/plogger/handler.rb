require 'plogger/id_generator'
require 'plogger/formatter'

module Plogger
  class Handler
    def initialize(config)
      @logger = config.logger
      @module = config.module
    end

    def handle_exception(exception, type: '', category: '', user_id: nil, account_id: nil, extra_info: {})
      handle_error(exception.message, category: category, user_id: user_id, account_id: account_id,
                                      extra_info: extra_info, type: type)
    end

    def handle_error(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id, type: type,
                                                extra_info: generate_extra_info(extra_info))
      @logger.error(result[:message])
      result[:trace]
    end

    def handle_warning(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id, type: type,
                                                extra_info: generate_extra_info(extra_info))
      @logger.warn(result[:message])
      result[:trace]
    end

    def handle_info(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id, type: type,
                                                extra_info: generate_extra_info(extra_info))
      @logger.info(result[:message])
      result[:trace]
    end

    def handle_debug(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
      result = generate_id_and_message(message, category: category, user_id: user_id,
                                                account_id: account_id, type: type,
                                                extra_info: generate_extra_info(extra_info))
      @logger.debug(result[:message])
      result[:trace]
    end

    private

    def generate_id_and_message(message, type: '', category: '', user_id: '', account_id: '', extra_info: {})
      trace = Plogger::IdGenerator.generate
      formatted_message = Plogger::Formatter.format(message, trace, user_id: user_id,
                                                                    account_id: account_id,
                                                                    category: category,
                                                                    type: type,
                                                                    extra_info: extra_info)
      {trace: trace, message: formatted_message}
    end

    def generate_extra_info extra_info
      extra_info.merge({module: @module})
    end
  end
end
