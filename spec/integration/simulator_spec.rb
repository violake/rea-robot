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
  end
end
