module Rix
  module Commands
    class UnknownCommand
      def initialize(options)
        @message = "Unknown command: #{options[:name]}. Type 'rix help commands' for a list of available commands."
      end

      def help
        @message
      end

      def execute
        puts @message
      end
    end
  end
end
