module Rix
  module Commands
    class Help
      attr_accessor :out

      def help
        HELP
      end

      def execute
        case ARGV.size
        when 0
          out.puts Rix::HELP
        when 1
          name = ARGV[0]
          if name.downcase == 'commands'
            out.puts "Available commands:"
            Registry.instance.commands.each_key { |command| out.puts "  #{command}" }
          else
            out.puts Registry.instance[name].help
          end
        else
          out.puts HELP
        end
      end

      HELP = <<HELP
Usage:
  rix help
  rix help commands
  rix help <command>
HELP
    end
  end
end
