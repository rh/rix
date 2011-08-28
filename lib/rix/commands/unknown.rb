module Rix
  module Commands
    class UnknownCommand
      attr_accessor :out, :name

      def message
        "Unknown command: #{name}. Type 'rix help commands' for a list of available commands."
      end

      def help
        message
      end

      def execute
        out.puts message
      end
    end
  end
end
