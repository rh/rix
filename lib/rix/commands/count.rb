module Rix
  module Commands
    class Count < Command
      def help
        "Usage: rix count <xpath> <files>"
      end

      def before(path, nodes)
        puts "#{path}: #{nodes.size}"
      end
    end
  end
end
