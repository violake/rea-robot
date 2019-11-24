# frozen_string_literal: true

require 'spec_helper'
require 'simulation/direction'
require 'simulation/error'

describe Simulation::Direction do
  let(:direction_names) { described_class::NAMES }
  let(:direction_names_size) { direction_names.size }
  let(:direction_upcase_names) { direction_names.map { |n| n.to_s.upcase.to_sym } }
  let(:invalid_name) { 'aaa' }

  subject { described_class }

  describe 'initialize' do
    it 'should create a direction with a valid downcase direction name' do
      direction_names.map do |name|
        direction = described_class.new(name)
        expect(direction.name).to eq name.downcase.to_sym
      end
    end

    it 'should create a direction with a valid upcase direction name' do
      direction_upcase_names.map do |name|
        direction = described_class.new(name)
        expect(direction.name).to eq name.downcase.to_sym
      end
    end

    it 'should raise error if direction names invalid' do
      expect { described_class.new(invalid_name) }
        .to raise_error(Simulation::Error, 'Direction invalid, direction: aaa')
    end

    it 'should raise error if direction names nil' do
      expect { described_class.new(nil) }
        .to raise_error(Simulation::Error, 'Direction invalid, direction: ')
    end
  end

  describe 'previous_direction & next_direction' do
    context 'direction name is the first of enum' do
      let(:current_index) { 0 }
      let(:previous_index) { direction_names_size - 1 }
      let(:direction) { described_class.new(direction_names[current_index]) }

      it { expect(direction.previous_direction.name).to eq direction_names[previous_index] }
    end

    context 'direction name is not first of enum' do
      let(:current_index) { 2 }
      let(:previous_index) { 1 }
      let(:direction) { described_class.new(direction_names[current_index]) }

      it { expect(direction.previous_direction.name).to eq direction_names[previous_index] }
    end
  end

  describe 'next_direction' do
    context 'direction name is the last of enum' do
      let(:current_index) { direction_names_size - 1 }
      let(:next_index) { 0 }
      let(:direction) { described_class.new(direction_names[current_index]) }

      it { expect(direction.next_direction.name).to eq direction_names[next_index] }
    end

    context 'direction name is not the last of enum' do
      let(:current_index) { 1 }
      let(:next_index) { 2 }
      let(:direction) { described_class.new(direction_names[current_index]) }

      it { expect(direction.next_direction.name).to eq direction_names[next_index] }
    end
  end

  describe 'to_s' do
    let(:north) { 'north' }
    let(:direction) { described_class.new(north) }

    it { expect(direction.to_s).to eq north.upcase }
  end
end
