module Rix
  module Commands
    class Trim < Command

      def help
        "Usage: rix trim <xpath> <files>"
      end

      def on_element(element)
        element.text = element.text.strip if element.has_text?
      end

      def on_attribute(attribute)
        attribute.element.attributes[attribute.name] = attribute.to_s.strip
        attribute.element.attributes[attribute.name]
      end

      def on_text(text)
        stripped = text.to_s.strip
        # Leave 'empty' nodes intact
        if stripped.size > 0
          child = Text.new(stripped)
          text.replace_with(child)
          child.to_s
        else
          text.to_s
        end
      end

      def after(path, document)
        File.open(path, 'w') do |file|
          document.write file
        end
      end
    end
  end
end
