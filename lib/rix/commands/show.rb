module Rix
  module Commands
    class Show < Command
      def initialize
        @formatter = Formatters::Pretty.new
        @formatter.compact = true
      end

      def help
        "Usage: rix show <xpath> <files>"
      end

      def on_node(node)
        @formatter.write(node, $stdout)
        puts
      end
    end
  end
end
