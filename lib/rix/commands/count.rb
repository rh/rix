module Rix
  module Commands
    class Count < Command
      def help
        "Usage: rix count <xpath> <files>"
      end

      def before(name, document, nodes)
        out.puts "#{name}: #{nodes.size}"
      end
    end
  end
end
