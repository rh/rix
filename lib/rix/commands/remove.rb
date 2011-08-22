module Rix
  module Commands
    class Remove < Command

      def help
        "Usage: rix remove <xpath> <files>"
      end

      def on_node(node)
        node.parent.delete_element node if node.is_a? REXML::Element
        # BUG: 'node.element.delete_attribute node' doesn't work
        node.element.delete_attribute node.name if node.is_a? REXML::Attribute
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
