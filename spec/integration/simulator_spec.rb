# frozen_string_literal: true

require 'spec_helper'

require 'simulator'

RSpec.describe Simulator do
  describe 'execute a script file' do
    let(:test_folder) { './spec/test_scripts' }

    subject { described_class }

    context 'happy_path' do
      let(:file_path) { File.join(test_folder, 'happy_path') }
      let(:expect_output) { '1,3,WEST' }

      it 'should get robot status' do
        expect(STDOUT).to receive(:puts).with expect_output
        subject.new(file_path).run
      end
    end

    context 'ignore commands before place' do
      let(:file_path) { File.join(test_folder, 'ignore_command_before_place') }
      let(:expect_output) { '3,3,EAST' }

      it 'should get robot status' do
        expect(STDOUT).to receive(:puts).with expect_output
        subject.new(file_path).run
      end
    end

    context 'place twice' do
      let(:file_path) { File.join(test_folder, 'place_twice') }
      let(:expect_output) { '4,3,SOUTH' }

      it 'should get robot status' do
        expect(STDOUT).to receive(:puts).with expect_output
        subject.new(file_path).run
      end
    end

    context 'move outside' do
      let(:file_path) { File.join(test_folder, 'move_outside') }
      let(:expect_output) { '3,0,SOUTH' }

      it 'should get robot status' do
        expect(STDOUT).to receive(:puts).with expect_output
        subject.new(file_path).run
      end
    end

    context 'place outside' do
      let(:file_path) { File.join(test_folder, 'place_outside') }
      let(:expect_error_log) { 'robot will fall off table for position(3,-1)' }

      it 'should get robot status' do
        expect(Simulation::Logger).to receive(:error).with expect_error_log
        subject.new(file_path).run
      end
    end

    context 'invalid command' do
      let(:file_path) { File.join(test_folder, 'invalid_command') }
      let(:expect_error_log) { "command 'fly' is not supported" }

      it 'should get robot status' do
        expect(Simulation::Logger).to receive(:error).with expect_error_log
        subject.new(file_path).run
      end
    end

    context 'invalid param' do
      let(:file_path) { File.join(test_folder, 'invalid_param') }
      let(:expect_error_log) { 'coordinate should be integer!' }

      it 'should get robot status' do
        expect(Simulation::Logger).to receive(:error).with expect_error_log
        subject.new(file_path).run
      end
    end
  end

  describe 'cli' do
    let(:start_text) do
      <<~HEREDOC
        Please input a command for robot
          -h display commands and descriptions
          -q quit
      HEREDOC
    end
    let(:exit_command) { '-q' }
    let(:exit_text) { 'exit' }

    subject { described_class.new }

    context 'start cli' do
      before { $stdin = StringIO.new(exit_command) }

      after { $stdin = STDIN }

      it 'should place robot' do
        expect(STDOUT).to receive(:puts).with start_text
        expect(STDOUT).to receive(:puts).with exit_text

        subject.run
      end
    end

    context 'help command' do
      let(:help_command) { '-h' }
      let(:help_text) do
        <<~HEREDOC
          \s\s\s\sPLACE X,Y,F     - place robot on the table
          \s\s\s\sMOVE            - move forward
          \s\s\s\sLEFT            - turn left
          \s\s\s\sRIGHT           - turn right
          \s\s\s\sREPORT          - report the position of the robot
        HEREDOC
      end

      before { $stdin = StringIO.new("#{help_command}\n#{exit_command}") }

      after { $stdin = STDIN }

      it 'should output commands help' do
        expect(STDOUT).to receive(:puts).with start_text
        expect(STDOUT).to receive(:puts).with help_text
        expect(STDOUT).to receive(:puts).with exit_text

        subject.run
      end
    end

    context 'place and report' do
      let(:place) { 'place 1,2,north' }
      let(:report) { 'report' }
      let(:expect_report_text) { '1,2,NORTH' }

      before { $stdin = StringIO.new("#{place}\n#{report}\n#{exit_command}") }

      after { $stdin = STDIN }

      it 'should place robot' do
        expect(STDOUT).to receive(:puts).with start_text
        expect(STDOUT).to receive(:puts).with expect_report_text
        expect(STDOUT).to receive(:puts).with exit_text

        subject.run
      end
    end

    context 'error command' do
      let(:error_command) { 'come' }
      let(:command_error_text) { "command '#{error_command}' is not supported" }

      before { $stdin = StringIO.new("#{error_command}\n#{exit_command}") }

      after { $stdin = STDIN }

      it 'should output error message' do
        expect(STDOUT).to receive(:puts).with start_text
        expect(STDOUT).to receive(:puts).with command_error_text
        expect(STDOUT).to receive(:puts).with exit_text

        subject.run
      end
    end
  end
end
