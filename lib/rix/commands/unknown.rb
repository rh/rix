module Rix
  module Commands
    class UnknownCommand
      attr_accessor :name

      def message
        "Unknown command: #{name}. Type 'rix help commands' for a list of available commands."
      end

      def help
        message
      end

      def execute
        puts message
      end
    end
  end
end
