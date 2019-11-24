# frozen_string_literal: true

require 'utils/type_checker'

## Simulation::Position Class
#
#  Init Param: int coordinates
#  Aim: create an instance that has validation for coordinates and
#       methods to create new Position by delta
#  Guard: integer check for coordinates
#
#  Design: decoupled from Robot class
#          nagetive coordinates are valid for general purpose
#          position should not have the concept for 'move'
#          method return a new position according to delta is more general
#

module Simulation
  class Position
    attr_reader :coordinate_x, :coordinate_y

    def initialize(coordinate_x, coordinate_y)
      unless Utils::TypeChecker.integer?(coordinate_x) &&
             Utils::TypeChecker.integer?(coordinate_y)
        raise ArgumentError,
              'coordinate should be integer!'
      end

      @coordinate_x = coordinate_x.to_i
      @coordinate_y = coordinate_y.to_i
    end

    def next_position_by_delta(delta_x, delta_y)
      Position.new(coordinate_x + delta_x, coordinate_y + delta_y)
    end

    def to_s
      "#{coordinate_x},#{coordinate_y}"
    end
  end
end
