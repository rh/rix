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

      def on_element(element)
        element.name = @name
      end

      def on_attribute(attribute)
        attribute.name = @name
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
