# frozen_string_literal: true

## Simulation::Direction Class
#
#  Init Param: name of the direction
#  Aim: create an instance that has validation for direction names and
#       methods to create new Direction instance
#  Guard: NAMES to verify a name
#
#  Design: decoupled from Robot class
#          direction should not have the concept for 'left' or 'right'
#          implement prevoius and next direction method to support current requirement
#

module Simulation
  class Direction
    NAMES = %i[north west south east].freeze

    attr_reader :name

    def initialize(name)
      direction = name&.downcase&.to_sym

      unless valid?(direction)
        raise Simulation::Error.new(Simulation::Error::DIRECTION_INVALID,
                                    "Direction invalid, direction: #{name}")
      end

      @name = direction
    end

    def previous_direction
      Direction.new(previous_name)
    end

    def next_direction
      Direction.new(next_name)
    end

    def to_s
      name.upcase.to_s
    end

    private

    def previous_name
      NAMES[(NAMES.index(name) - 1) % NAMES.size]
    end

    def next_name
      NAMES[(NAMES.index(name) + 1) % NAMES.size]
    end

    def valid?(direction)
      NAMES.include?(direction)
    end
  end
end
