require 'spec_helper'

module Rix
  describe Registry do
    before do
      @registry = Registry.instance
    end

    it "always returns the same instance" do
      @registry.object_id == Registry.instance.object_id
    end

    it "always returns a command" do
      key = 'foo'
      @registry.commands.should_not have_key(key)
      @registry[key].should_not be_nil
    end

    it "sets the name of an unknown command" do
      @registry['foo'].name.should == 'foo'
    end
  end
end
