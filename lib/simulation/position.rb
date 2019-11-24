# frozen_string_literal: true

module Simulation
  class Position
    attr_reader :coordinate_x, :coordinate_y

    def initialize(coordinate_x, coordinate_y)
      unless integer?(coordinate_x) &&
             integer?(coordinate_y)
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

    private

    def integer?(obj)
      obj.to_s.to_i.to_s == obj.to_s
    end
  end
end
