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
      command.name = name if command.respond_to? :name
      command
    end
  end
end
