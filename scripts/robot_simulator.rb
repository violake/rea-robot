#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
$LOAD_PATH.unshift('./lib')
require 'simulator'

Simulator.new(ARGV[0]).run
