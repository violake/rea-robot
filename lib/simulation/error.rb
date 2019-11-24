# frozen_string_literal: true

module Simulation
  class Error < StandardError
    attr_reader :error_type

    COMMNAD_INVALID = 'command_invalid'
    ARGUMENT_INVALID = 'argument_invalid'
    DIRECTION_INVALID = 'direction_invalid'
    ROBOT_NOT_PALCED = 'robot_not_placed'
    POSITION_OUT_OF_TABLE = 'position_out_of_table'

    def initialize(error_type, error_message = '')
      super(error_message)
      @error_type = error_type
    end
  end
end
