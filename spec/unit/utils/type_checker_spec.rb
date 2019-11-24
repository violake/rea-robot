# frozen_string_literal: true

require 'spec_helper'
require 'utils/type_checker'

describe Utils::TypeChecker do
  subject { Utils::TypeChecker }

  describe '#integer?' do
    it 'should be true if a object is an integer' do
      expect(subject.integer?(3)).to be_truthy
      expect(subject.integer?('3')).to be_truthy
    end

    it 'should be false if a object is not an integer' do
      expect(subject.integer?('a')).to be_falsy
    end

    it 'should be true if nil' do
      expect(subject.integer?(nil)).to be_falsy
    end
  end

  describe '#positive?' do
    it 'should be true if a object is an integer and greater than 0' do
      expect(subject.positive_integer?(3)).to be_truthy
      expect(subject.positive_integer?('3')).to be_truthy
    end

    it 'should be false if a object is an positive_integer and less than 0' do
      expect(subject.positive_integer?(-3)).to be_falsy
      expect(subject.positive_integer?('-3')).to be_falsy
    end

    it 'should be false if a object is not an positive_integer' do
      expect(subject.positive_integer?('a')).to be_falsy
    end

    it 'should be true if nil' do
      expect(subject.positive_integer?(nil)).to be_falsy
    end
  end
end
