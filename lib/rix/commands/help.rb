module Rix
  module Commands

    class Help < Command
      def help
        HELP
      end

      def execute
        case ARGV.size
        when 0
          puts Rix::HELP
        when 1
          name = ARGV[0]
          if name.downcase == 'commands'
            puts "Available commands:"
            Command.all.each_key { |command| puts "  #{command}" }
          else
            puts Command[name].help
          end
        else
          puts HELP
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