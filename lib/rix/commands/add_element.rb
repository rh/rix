module Rix
  module Commands
    class AddElement < Command
      attr_accessor :name
      attr_accessor :value

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix add-element [options] <xpath> <files>"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-n", "--name NAME", "The name of the new element") { |name| @name = name }
          opts.on("-v", "--value VALUE", "The value of the new element") { |value| @value = value }
        end
      end

      def before_all
        raise "Missing option: -n, --name" if @name.nil? or @name.empty?
      end

      def on_element(parent)
        element = parent.add_element @name
        element.text = @value
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
