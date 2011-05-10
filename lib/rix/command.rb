require 'rix/commands/unknown'

module Rix

  class Command
    class << self
      def inherited(subclass)
        name = subclass.name.split(':').last.downcase
        all[name] = subclass
      end

      def all
        @all ||= Hash.new(Commands::UnknownCommand)
      end

      def [](name)
        all[name].new(:name => name)
      end
    end
  end

end
