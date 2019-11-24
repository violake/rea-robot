# frozen_string_literal: true

require 'spec_helper'
require 'simulation/position'

describe Simulation::Position do
  let(:coordinate_x) { 3 }
  let(:coordinate_y) { 2 }

  subject { described_class }

  describe 'initialize' do
    it 'should create a position by int coordinate' do
      position = subject.new(coordinate_x, coordinate_y)
      expect(position.coordinate_x).to eq coordinate_x
      expect(position.coordinate_y).to eq coordinate_y
    end

    it 'should create a position by string coordinate' do
      position = subject.new(coordinate_x.to_s, coordinate_y.to_s)
      expect(position.coordinate_x).to eq coordinate_x
      expect(position.coordinate_y).to eq coordinate_y
    end

    it 'should raise error if coordinates invalid' do
      expect { subject.new('a', 'b') }.to raise_error(ArgumentError,
                                                      'coordinate should be integer!')
    end

    it 'should raise error if coordinates nil' do
      expect { subject.new(nil, nil) }.to raise_error(ArgumentError,
                                                      'coordinate should be integer!')
    end
  end

  describe 'next_position_by_delta' do
    let(:position) { subject.new(coordinate_x, coordinate_y) }

    context 'positive delta' do
      let(:delta_x) { 1 }
      let(:delta_y) { 2 }
      let(:next_position) { position.next_position_by_delta(delta_x, delta_y) }

      it { expect(next_position.coordinate_x).to eq coordinate_x + delta_x }
      it { expect(next_position.coordinate_y).to eq coordinate_y + delta_y }
    end

    context 'zero delta' do
      let(:delta_x) { 0 }
      let(:delta_y) { 0 }
      let(:next_position) { position.next_position_by_delta(delta_x, delta_y) }

      it { expect(next_position.coordinate_x).to eq coordinate_x }
      it { expect(next_position.coordinate_y).to eq coordinate_y }
    end

    context 'nagetive delta' do
      let(:delta_x) { -1 }
      let(:delta_y) { -3 }
      let(:next_position) { position.next_position_by_delta(delta_x, delta_y) }

      it { expect(next_position.coordinate_x).to eq coordinate_x + delta_x }
      it { expect(next_position.coordinate_y).to eq coordinate_y + delta_y }
    end
  end

  describe 'to_s' do
    it 'should serializable' do
      position = subject.new(coordinate_x, coordinate_y)
      expect(position.to_s).to eq("#{coordinate_x},#{coordinate_y}")
    end
  end
end
