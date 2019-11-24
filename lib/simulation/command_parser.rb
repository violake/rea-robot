# frozen_string_literal: true

require 'simulation/error'

## Simulation::CommandParser Class
#
#  Init Param: command string to be parsed
#  Aim: parse all the command string to a command_executor
#  Guard: SUPPORTED_COMMANDS to verify a command and raise error if not
#
#  Design: all the command must be extracted and verified.
#          currently it looks like the same pattern
#          'curry' is a kind of lambda creater which can implement a pattern
#          that returns a method to call the command and arguments for the future object
#

module Simulation
  class CommandParser
    attr_reader :command, :args

    SUPPORTED_COMMANDS = %i[place move left right report].freeze

    COMMAND_EXECUTOR = ->(command, args, obj) { obj.public_send(command, *args) }.curry

    def initialize(command_str)
      command, *rest = command_str&.split(' ')
      @command = command.downcase.to_sym
      @args = rest[0]&.split(',')
    end

    def executor
      unless valid_command?
        raise Simulation::Error.new(Simulation::Error::COMMNAD_INVALID,
                                    "command '#{command}' is not supported")
      end

      COMMAND_EXECUTOR.call(command, args)
    end

    private

    def valid_command?
      SUPPORTED_COMMANDS.include?(command)
    end
  end
end
