module Rix
  module Commands
    class Rename < Command
      attr_accessor :name

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix rename [options] <xpath> <files>"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-n", "--name NAME", "The new name") { |name| @name = name }
        end
      end

      def before_all
        raise "Missing option: -n, --name" if @name.nil? or @name.empty?
      end

      def on_node(node)
        node.name = @name if node.respond_to? :name
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
