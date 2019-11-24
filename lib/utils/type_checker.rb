# frozen_string_literal: true

module Utils
  class TypeChecker
    class << self
      def integer?(obj)
        obj.to_s.to_i.to_s == obj.to_s
      end

      def positive_integer?(obj)
        integer?(obj) && obj.to_s.to_i.positive?
      end
    end
  end
end
