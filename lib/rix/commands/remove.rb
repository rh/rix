module Rix
  module Commands
    class Remove < Command

      def help
        "Usage: rix remove <xpath> <files>"
      end

      def on_element(element)
        element.parent.delete_element element
      end

      def on_attribute(attribute)
        # BUG: 'attribute.element.delete_attribute attribute' doesn't work
        attribute.element.delete_attribute attribute.name
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
