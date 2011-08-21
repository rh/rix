module Rix
  module Commands
    class AddElement < Command
      attr_accessor :files
      attr_accessor :xpath
      attr_accessor :name
      attr_accessor :value

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix add-element [options] <xpath expression> [file(s) and/or pattern(s)]"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-n", "--name NAME", "The name of the new element") { |name| @name = name }
          opts.on("-v", "--value VALUE", "The value of the new element") { |value| @value = value }
        end
      end

      def help
        opts.help
      end

      def execute
        @files = []
        @value = ""

        opts.parse!

        @xpath = ARGV.shift.dup if ARGV.size > 0
        # @files will hold all remaining command-line arguments on Windows,
        # and expanded filenames on Mac, Linux etc.
        @files = ARGV.uniq      if ARGV.size > 0

        raise "Missing XPath expression" if @xpath.nil? or @xpath.empty?
        raise "Missing option: -n, --name" if @name.nil? or @name.empty?

        @files.each do |pattern|
          # Using Dir is only needed for Windows, where arguments are not expanded,
          # on Mac, Linux etc. this will have no effect.
          Dir[pattern].each do |path|
            File.open(path, 'r+') do |file|
              document = REXML::Document.new(file)
              REXML::XPath.each(document, @xpath) do |node|
                element = node.add_element @name
                element.text = @value
              end
              file.truncate 0
              file.pos = 0
              document.write file
            end
          end
        end
      end
    end
  end
end