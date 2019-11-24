# frozen_string_literal: true

require 'simulation/position'
require 'simulation/direction'
require 'simulation/error'

module Simulation
  class Robot
    DEFAULT_PACE = 1

    attr_reader :position, :table, :direction

    def initialize(table)
      @table = table
    end

    def place(coordinate_x, coordinate_y, direction_name)
      position = Position.new(coordinate_x, coordinate_y)
      direction = Direction.new(direction_name)
      raise_if_fall_off_table(position)

      @position = position
      @direction = direction
    end

    def move
      raise_if_not_placed

      new_position = position.next_position_by_delta(*moving_delta)
      raise_if_fall_off_table(new_position)

      @position = new_position
    end

    def left
      raise_if_not_placed

      @direction = direction.next_direction
    end

    def right
      raise_if_not_placed

      @direction = direction.previous_direction
    end

    def report
      raise_if_not_placed

      puts "#{position},#{direction}"
    end

    private

    def placed?
      table && position && direction
    end

    def raise_if_not_placed
      unless placed?
        raise Simulation::Error.new(Simulation::Error::ROBOT_NOT_PALCED, 'robot not placed')
      end
    end

    def raise_if_fall_off_table(position)
      unless table.inside?(position.coordinate_x, position.coordinate_y)
        raise Simulation::Error.new(Simulation::Error::POSITION_OUT_OF_TABLE,
                                    "robot will fall off table for position(#{position})")
      end
    end

    def moving_delta(pace = DEFAULT_PACE)
      delta = delta_by_direction(pace)[direction.name]

      unless delta
        raise Simulation::Error.new(Simulation::Error::DIRECTION_INVALID,
                                    "direction '#{direction}' could not forward!")
      end

      delta
    end

    def delta_by_direction(pace)
      {
        north: [0, pace],
        west: [-pace, 0],
        south: [0, -pace],
        east: [pace, 0]
      }
    end
  end
end
