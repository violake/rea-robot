# frozen_string_literal: true

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
