# frozen_string_literal: true

require 'simulation/command_parser'
require 'simulation/logger'
require 'simulation/robot'
require 'simulation/table'
require 'simulator_cli'

## Simulator Class
#
#  Init Param: <script file>
#  Aim: main class for this simulation.
#       initialize a table and a robot and start to run scripts or start cli
#
#  Design: both script runner and cli will have to initialize table object and robot object
#          and have the same action to run commands read in. So I implement it in one class
#          In this case, I make SimulatorCli to be a pure cli class with no logic but help text
#
#  Concern: because error handling for script runner and cli are totally different
#           maybe it's better to have two different classes to handle this polymorphism
#           but this will create lots of duplication if doing so
#           maybe could separate them when there are more differences
#

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
    running_cli? ? start_cli : run_script
  end

  private

  def running_cli?
    script_file.nil?
  end

  def run_script
    file = File.open(script_file, 'r')
    file.each_line do |line|
      run_command line
    end
    file.close
  end

  def start_cli
    SimulatorCli.new.start do |command|
      run_command command
    end
  end

  def run_command(command_str)
    Simulation::CommandParser.new(command_str).executor.call(robot)
  rescue Simulation::Error, ArgumentError => e
    if running_cli?
      puts e.message
    else
      Simulation::Logger.error(e.message) unless ignore_error_when_runnning_script?(e)
    end
  end

  # ignore correct command before a place command when running a script file
  def ignore_error_when_runnning_script?(error)
    error.instance_of?(Simulation::Error) &&
      error.error_type == Simulation::Error::ROBOT_NOT_PALCED
  end
end
