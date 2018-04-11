module Plogger
  class IdGenerator
    def self.generate
      [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten.shuffle[0, id_length].join
    end

    def self.id_length
      10
    end
  end
end