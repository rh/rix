module Rix

  class Command
    class << self
      def inherited(subclass)
        name = subclass.name.split(':').last.downcase
        all[name] = subclass
      end

      def all
        @all ||= {}
      end

      def [](name)
        (all[name] || UnknownCommand).new(:name => name)
      end
    end
  end

  class UnknownCommand
    def initialize(options)
      @message = "Unknown command: #{options[:name]}. Type 'rix help commands' for a list of available commands."
    end

    def execute
      puts @message
    end
  end
end