# frozen_string_literal: true

require 'spec_helper'
require 'simulation/robot'

describe Simulation::Robot do
  let(:dimension_x) { 6 }
  let(:dimension_y) { 6 }
  let(:coordinate_x) { 2 }
  let(:coordinate_y) { 3 }
  let(:error_coordinate_x) { 7 }
  let(:direction_name) { 'NORTH' }
  let(:table) { Simulation::Table.new(dimension_x, dimension_y) }
  let(:robot) { Simulation::Robot.new(table) }

  describe 'place' do
    context 'correct position' do
      before { robot.place(coordinate_x, coordinate_y, direction_name) }

      it { expect(robot.position.coordinate_x).to eq coordinate_x }
      it { expect(robot.position.coordinate_y).to eq coordinate_y }
    end

    context 'incorrect position' do
      it 'should raise error if position is out of table' do
        expect { robot.place(error_coordinate_x, coordinate_y, direction_name) }
          .to raise_error(
            Simulation::Error,
            "robot will fall off table for position(#{error_coordinate_x},#{coordinate_y})"
          )
      end
    end
  end

  describe 'move' do
    context 'robot not placed' do
      it { expect { robot.move }.to raise_error(Simulation::Error) }
    end

    context 'next position in table' do
      context 'facting north' do
        let(:north) { 'NORTH' }
        before do
          robot.place(coordinate_x, coordinate_y, north)
          robot.move
        end

        it { expect(robot.position.coordinate_x).to eq coordinate_x }
        it { expect(robot.position.coordinate_y).to eq coordinate_y + 1 }
      end

      context 'facting east' do
        let(:north) { 'EAST' }
        before do
          robot.place(coordinate_x, coordinate_y, north)
          robot.move
        end

        it { expect(robot.position.coordinate_x).to eq coordinate_x + 1 }
        it { expect(robot.position.coordinate_y).to eq coordinate_y }
      end

      context 'facting south' do
        let(:north) { 'SOUTH' }
        before do
          robot.place(coordinate_x, coordinate_y, north)
          robot.move
        end

        it { expect(robot.position.coordinate_x).to eq coordinate_x }
        it { expect(robot.position.coordinate_y).to eq coordinate_y - 1 }
      end

      context 'facting west' do
        let(:north) { 'WEST' }
        before do
          robot.place(coordinate_x, coordinate_y, north)
          robot.move
        end

        it { expect(robot.position.coordinate_x).to eq coordinate_x - 1 }
        it { expect(robot.position.coordinate_y).to eq coordinate_y }
      end
    end

    context 'next position not in table' do
      before { robot.place(coordinate_x, dimension_y, direction_name) }

      it 'should raise error' do
        expect { robot.move }
          .to raise_error(
            Simulation::Error,
            "robot will fall off table for position(#{coordinate_x},#{dimension_y + 1})"
          )
      end
    end

    context 'direction that could not move' do
      let(:unknow_direction_name) { 'SKY' }

      before do
        allow_any_instance_of(Simulation::Direction).to receive(:valid?).and_return(true)
        robot.place(coordinate_x, coordinate_y, unknow_direction_name)
      end

      it 'should raise error' do
        expect { robot.move }
          .to raise_error(Simulation::Error,
                          "direction '#{unknow_direction_name}' could not forward!")
      end
    end
  end

  describe 'left' do
    context 'robot not placed' do
      it { expect { robot.left }.to raise_error(Simulation::Error) }
    end

    context 'robot placed' do
      let(:expect_direction_name) { :west }

      before do
        robot.place(coordinate_x, coordinate_y, direction_name)
        robot.left
      end

      it { expect(robot.direction.name).to eq expect_direction_name }
    end
  end

  describe 'right' do
    context 'robot not placed' do
      it { expect { robot.right }.to raise_error(Simulation::Error) }
    end

    context 'robot placed' do
      let(:expect_direction_name) { :east }

      before do
        robot.place(coordinate_x, coordinate_y, direction_name)
        robot.right
      end

      it { expect(robot.direction.name).to eq expect_direction_name }
    end
  end

  describe 'report' do
    context 'robot not placed' do
      it { expect { robot.report }.to raise_error(Simulation::Error) }
    end

    context 'robot placed' do
      before { robot.place(coordinate_x, coordinate_y, direction_name) }

      it 'should report report status' do
        expect(STDOUT).to receive(:puts).with "#{coordinate_x},#{coordinate_y},#{direction_name}"
        robot.report
      end
    end
  end
end
