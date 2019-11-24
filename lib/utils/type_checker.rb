# frozen_string_literal: true

## Utils::TypeChecker Class
#
#  Aim: value checker
#
#  Design: currently check integer and positive integer
#          string whose value can pass the checker will return true
#
#  Concerns: to make app more adaptable to command script or user input
#            the factor that string of int and int value are valid caused
#            have to call '.to_i' each time using 'int param'
#

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
