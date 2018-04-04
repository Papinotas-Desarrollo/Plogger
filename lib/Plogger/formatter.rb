module Plogger
  class Formatter
    def self.format(message, trace, user_id: 'null', account_id: 'null', category: '', extra_info: {})
      result = "#{message} -- category='#{category}' user_id=#{user_id} account_id=#{account_id} trace=#{trace}"
      extra_info.keys.each do |key|
        is_string = extra_info[key].class == String
        result += " #{key}=#{is_string ? "'" : ''}#{extra_info[key]}#{is_string ? "'" : ''}"
      end
      result
    end
  end
end