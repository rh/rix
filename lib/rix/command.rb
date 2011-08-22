require 'rix/commands/unknown'

module Rix
  class Command
    attr_accessor :files
    attr_accessor :xpath

    def opts
      OptionParser.new
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

      before_all

      @files.each do |pattern|
        # Using Dir is only needed for Windows, where arguments are not expanded,
        # on Mac, Linux etc. this will have no effect.
        Dir[pattern].each do |path|
          File.open(path, 'r+') do |file|
            document = REXML::Document.new(file)
            nodes = REXML::XPath.match(document, @xpath)
            before(path, nodes)
            nodes.each do |node|
              on_node(node)
            end
            after
            #file.truncate 0
            #file.pos = 0
            #document.write file
          end
        end
      end

      after_all
    end

    def before_all
    end

    def before(path, nodes)
    end

    def on_node(node)
    end

    def after
    end

    def after_all
    end
  end
end
