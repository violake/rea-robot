# frozen_string_literal: true

class SimulatorCli
  COMMAND_PROMPT = '>'
  COMMAND_EXIT = 'exit'

  HELP_MESSAGE = <<~HEREDOC
    Please input a command for robot
    \s\s-h display commands and descriptions
    \s\s-q quit
  HEREDOC

  COMMANDS_DESCRIPTION = <<-HEREDOC
    PLACE X,Y,F     - place robot on the table
    MOVE            - move forward
    LEFT            - turn left
    RIGHT           - turn right
    REPORT          - report the position of the robot
  HEREDOC

  def start
    puts HELP_MESSAGE

    loop do
      print COMMAND_PROMPT

      command = gets.chomp
      next if command.empty?

      case command.downcase.to_sym
      when :'-h'
        puts COMMANDS_DESCRIPTION
      when :'-q'
        puts COMMAND_EXIT
        break
      else
        yield command
      end
    end
  end
end
