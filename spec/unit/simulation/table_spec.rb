# frozen_string_literal: true

require 'spec_helper'
require 'simulation/table'

describe Simulation::Table do
  let(:dimension_x) { 7 }
  let(:dimension_y) { 8 }

  subject { described_class }

  describe 'initialize' do
    it 'should create table when parameter positive integer' do
      table = subject.new(dimension_x, dimension_y)
      expect(table.dimension_x).to eq dimension_x
      expect(table.dimension_y).to eq dimension_y
    end

    it 'should create table when parameter positive string' do
      table = subject.new(dimension_x.to_s, dimension_y.to_s)
      expect(table.dimension_x).to eq dimension_x
      expect(table.dimension_y).to eq dimension_y
    end

    it 'should raise error if dimension is invalid' do
      expect { subject.new('a', '3') }.to raise_error(ArgumentError)
      expect { subject.new(nil, 5) }.to raise_error(ArgumentError)
      expect { subject.new(-2, 5) }.to raise_error(ArgumentError)
    end
  end

  describe 'inside?' do
    let(:inside_coordinate) { [3, 5] }
    let(:outside_coordinate) { [8, 2] }
    let(:table) { subject.new(dimension_x, dimension_y) }

    it 'should return true if valid position' do
      expect(table.inside?(*inside_coordinate)).to be_truthy
    end

    it 'should return false if invalid position' do
      expect(table.inside?(*outside_coordinate)).to be_falsey
    end

    it 'should return false if position is nil' do
      expect(table.inside?(nil, nil)).to be_falsey
    end
  end

  describe 'to_s' do
    it 'should be serializable' do
      table = subject.new(dimension_x, dimension_y)
      expect(table.to_s).to eq "Table(#{dimension_x},#{dimension_y})"
    end
  end
end
