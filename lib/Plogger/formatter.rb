module Plogger
  class Formatter
    def self.format(message, trace, type: 'system', user_id: nil, account_id: nil, category: '', extra_info: {})
      result = "#{message} -- trace='#{trace}'"
      args = {type: type, category: category, user_id: user_id, account_id: account_id}
      args.each do |key, value|
        result = add_param_to_message(result, key, value) unless value.nil?
      end

      extra_info.keys.each do |key|
        result = add_param_to_message(result, key, extra_info[key])
      end
      result
    end

    def self.add_param_to_message(message, key, value)
      result = message
      is_string = value.class == String
      result += " #{key}=#{is_string ? "'" : ''}#{value}#{is_string ? "'" : ''}"
      result
    end

  end
end