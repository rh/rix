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
        (all[name] || Commands::UnknownCommand).new(:name => name)
      end
    end
  end

end
