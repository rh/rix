require 'rix/commands/unknown'

module Rix
  class Command
    attr_accessor :out
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
          File.open(path, 'r') do |file|
            on_source(file, path)
          end
        end
      end

      after_all
    end

    def on_source(source, name)
      document = Document.new(source, :ignore_whitespace_nodes => :all, :attribute_quote => :quote)
      on_document(document, name)
    end

    def on_document(document, name)
      nodes = XPath.match(document, @xpath)
      before(name, document, nodes)
      nodes.each do |node|
        on_node(node)
        on_element(node)   if node.is_a? Element
        on_attribute(node) if node.is_a? Attribute
        on_text(node)      if node.is_a? Text
      end
      after(name, document)
    end

    def before_all; end

    def before(name, document, nodes); end

    def on_node(node); end

    def on_element(element); end

    def on_attribute(attribute); end

    def on_text(text); end

    def after(name, document); end

    def after_all; end
  end
end
