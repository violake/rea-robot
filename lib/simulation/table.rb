# frozen_string_literal: true

module Simulation
  class Table
    attr_reader :dimension_x, :dimension_y

    def initialize(dimension_x, dimension_y)
      unless positive_integer?(dimension_x) &&
             positive_integer?(dimension_y)
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

    private

    def positive_integer?(obj)
      obj.to_s.to_i.to_s == obj.to_s && obj.to_s.to_i.positive?
    end
  end
end
