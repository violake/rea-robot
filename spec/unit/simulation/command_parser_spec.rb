# frozen_string_literal: true

require 'spec_helper'
require 'simulation/command_parser'

describe Simulation::CommandParser do
  let(:command) { described_class::SUPPORTED_COMMANDS.sample.to_s }
  let(:invalid_command) { 'SOME_COMMAND' }
  let(:single_arg) { 'f' }
  let(:double_args) { 'd,e' }
  let(:triple_args) { 'a,b,c' }

  describe 'call' do
    let(:obj) { double }
    context 'correct command with any parameters' do
      it 'should return a lambda with no arg' do
        expect(obj).to receive(command.to_sym).with(no_args)
        described_class.new(command).executor.call(obj)
      end

      it 'should return a lambda with single arg' do
        expectation_of_calling_obj_method(obj, command, single_arg)
      end

      it 'should return a lambda with double args' do
        expectation_of_calling_obj_method(obj, command, double_args)
      end

      it 'should return a lambda with triple args' do
        expectation_of_calling_obj_method(obj, command, triple_args)
      end

      it 'should return same lambda with extra parameter' do
        expectation_of_calling_obj_method(obj, command, double_args, single_arg)
      end
    end

    context 'incorrect command' do
      it 'should raise error' do
        command_str = "#{invalid_command} #{single_arg}"

        expect { described_class.new(command_str).executor.call(obj) }
          .to raise_error(Simulation::Error,
                          "command '#{invalid_command.downcase}' is not supported")
      end
    end
  end

  private

  def expectation_of_calling_obj_method(obj, command, args, extra_args = nil)
    command_str = "#{command} #{args} #{extra_args}"

    expect(obj).to receive(command.to_sym).with(*args.split(','))
    described_class.new(command_str).executor.call(obj)
  end
end
