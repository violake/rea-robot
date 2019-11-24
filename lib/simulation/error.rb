# frozen_string_literal: true

## Simulation::Error Class
#
#  Aim: distinct errors and type defination
#
#  Design: a bunch of errors in one error class
#
#  Concern: this is greate if error handling or formatting are in same pattern
#           but it's kind of verbose when new such an error
#

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
