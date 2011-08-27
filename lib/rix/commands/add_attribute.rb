module Rix
  module Commands
    class AddAttribute < Command
      attr_accessor :name
      attr_accessor :value

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix add-attribute [options] <xpath> <files>"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-n", "--name NAME", "The name of the new attribute") { |name| @name = name }
          opts.on("-v", "--value VALUE", "The value of the new attribute") { |value| @value = value }
        end
      end

      def before_all
        raise "Missing option: -n, --name" if @name.nil? or @name.empty?
      end

      def on_element(element)
        element.add_attribute(@name, @value)
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
