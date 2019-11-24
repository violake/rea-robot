# frozen_string_literal: true

require 'spec_helper'
require 'simulation/logger'

RSpec.describe Simulation::Logger do
  describe 'logger' do
    it 'return a logger instance' do
      expect(described_class.send('logger')).to a_kind_of(Logger)
    end
  end

  describe 'error' do
    let(:error_message) { 'some error' }

    it 'should write error log' do
      expect_any_instance_of(Logger).to receive(:error).with(error_message)
      described_class.error(error_message)
    end
  end

  describe 'warn' do
    let(:error_message) { 'some error' }

    it 'should write error log' do
      expect_any_instance_of(Logger).to receive(:error).with(error_message)
      described_class.error(error_message)
    end
  end
end
