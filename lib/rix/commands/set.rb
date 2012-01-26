module Rix
  module Commands
    class Set < Command
      attr_accessor :value

      def opts
        OptionParser.new do |opts|
          opts.banner = "Usage: rix set [options] <xpath> <files>"
          opts.separator ""
          opts.separator "Options:"
          opts.on("-v", "--value VALUE", "The value to set") { |value| @value = value }
        end
      end

      def on_element(element)
        element.text = @value || ""
      end

      def on_attribute(attribute)
        attribute.element.attributes[attribute.name] = @value || ""
      end

      def on_text(text)
        node = Text.new(@value || "")
        text.replace_with(node)
        node.to_s
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
