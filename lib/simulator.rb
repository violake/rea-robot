# frozen_string_literal: true

require 'simulation/command_parser'
require 'simulation/robot'
require 'simulation/table'

class Simulator
  attr_reader :script_file, :robot

  TABLE_DIMENSION_X = 5
  TABLE_DIMENSION_Y = 5

  def initialize(script_file = nil)
    @script_file = script_file
    @table = Simulation::Table.new(TABLE_DIMENSION_X, TABLE_DIMENSION_Y)
    @robot = Simulation::Robot.new(@table)
  end

  def run
    file = File.open(script_file, 'r')
    file.each_line do |line|
      run_command line
    end
    file.close
  end

  private

  def run_command(command_str)
    Simulation::CommandParser.new(command_str).executor.call(robot)
  end
end
