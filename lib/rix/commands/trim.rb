module Rix
  module Commands
    class Trim < Command

      def help
        "Usage: rix trim <xpath> <files>"
      end

      def on_node(node)
        node.text = node.text.strip if node.is_a? REXML::Element
        node.element.attributes[node.name] = node.to_s.strip if node.is_a? REXML::Attribute
        if node.is_a? REXML::Text
          stripped = node.to_s.strip
          # Leave 'empty' nodes intact
          if stripped.size > 0
            node.replace_with(REXML::Text.new(stripped))
          end
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
