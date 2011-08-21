module Rix
  module Commands
    class Count < Command
      attr_accessor :files
      attr_accessor :xpath

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix count <xpath expression> [file(s) and/or pattern(s)]"
        end
      end

      def help
        opts.help
      end

      def execute
        @files = []

        opts.parse!

        @xpath = ARGV.shift.dup if ARGV.size > 0
        # @files will hold all remaining command-line arguments on Windows,
        # and expanded filenames on Mac, Linux etc.
        @files = ARGV.uniq      if ARGV.size > 0

        raise "Missing XPath expression" if @xpath.nil? or @xpath.empty?

        @files.each do |pattern|
          # Using Dir is only needed for Windows, where arguments are not expanded,
          # on Mac, Linux etc. this will have no effect.
          Dir[pattern].each do |path|
            File.open(path) do |file|
              document = REXML::Document.new(file)
              nodes = REXML::XPath.match(document, @xpath)
              puts "#{path}: #{nodes.size}"
            end
          end
        end
      end
    end
  end
end