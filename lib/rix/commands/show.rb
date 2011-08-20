module Rix
  module Commands
    class Show < Command
      attr_accessor :files
      attr_accessor :xpath

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix show [options]"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-f", "--files FILES", "The name(s) or pattern(s) of the file(s) to process, separated by ':'.") { |files| @files = files }
          opts.on("-x", "--xpath EXPRESSION", "The XPath expression used for selection.") { |xpath| @xpath = xpath }
        end
      end

      def help
        opts.help
      end

      def execute
        opts.parse!

        raise "Missing option: -f, --files" if @files.nil? or @files.empty?
        raise "Missing option: -x, --xpath" if @xpath.nil? or @xpath.empty?

        formatter = REXML::Formatters::Pretty.new
        formatter.compact = true

        @files.split(":").each do |pattern|
          Dir[pattern].each do |path|
            File.open(path) do |file|
              document = REXML::Document.new(file)
              nodes = REXML::XPath.match(document, @xpath)
              puts "#{path}: #{nodes.size}"
              nodes.each do |node|
                formatter.write(node, $stdout)
                puts
              end
            end
          end
        end
      end
    end
  end
end