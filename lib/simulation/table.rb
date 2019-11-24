# frozen_string_literal: true

require 'utils/type_checker'

## Simulation::Table Class
#
#  Init Param: dimensions
#  Aim: create an table that has dimensions and
#       methods to verify coordinates inside the table object
#  Guard: dimensions must be positive integer to ensure a reasonable table
#
#  Design: Two-dimensional table support any size of dimension that is positive integer
#          when validate a position is in table should use coordinates directly
#          as table needn't to know the existance of Position
#

module Simulation
  class Table
    attr_reader :dimension_x, :dimension_y

    def initialize(dimension_x, dimension_y)
      unless Utils::TypeChecker.positive_integer?(dimension_x) &&
             Utils::TypeChecker.positive_integer?(dimension_y)
        raise ArgumentError,
              'dimension should be positive integer!'
      end

      @dimension_x = dimension_x.to_i
      @dimension_y = dimension_y.to_i
    end

    def inside?(coordinate_x, coordinate_y)
      (0..dimension_x).cover?(coordinate_x) &&
        (0..dimension_y).cover?(coordinate_y)
    end

    def to_s
      "Table(#{dimension_x},#{dimension_y})"
    end
  end
end
