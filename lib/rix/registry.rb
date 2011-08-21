require 'rix/commands/unknown'

module Rix
  class Registry
    def self.instance
      @instance ||= new
    end

    attr_reader :commands

    def initialize
      @commands = Hash.new(Commands::UnknownCommand)
    end

    def register(name, klass)
      @commands[name] = klass
    end

    def [](name)
      command = @commands[name].new
      command.name = name if command.is_a? Commands::UnknownCommand
      command
    end
  end
end
