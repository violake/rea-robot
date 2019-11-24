# frozen_string_literal: true

require 'logger'

## Simulation::Logger Class
#
#  Aim: log error message when running script
#
#  Design: singleton logger instance.
#          deligate error method of Logger instance
#

module Simulation
  class Logger
    class << self
      def error(message)
        logger.error(message)
      end

      private

      def logger
        @logger ||= ::Logger.new(log_file)
      end

      def log_file
        File.directory?(log_file_directory) || FileUtils.mkdir_p(log_file_directory)
        "#{log_file_directory}/#{log_file_name}"
      end

      def log_file_directory
        File.expand_path('../../logs', __dir__)
      end

      def log_file_name
        "#{ENV.fetch('ENVIRONMENT', 'development')}.log"
      end
    end
  end
end
