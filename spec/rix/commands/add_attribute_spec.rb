require 'spec_helper'

module Rix
  module Commands
    describe AddAttribute do
      before(:all) do
        @command = AddAttribute.new
        @command.name = "foo"
        @command.value = "bar"
        @element = Element.new "element"
      end

      it "adds a new attribute" do
        @element.attributes.get_attribute("foo").should == nil
        @command.on_element(@element)
        @element.attributes["foo"].should == "bar"
      end

      it "changes the value of an existing attribute" do
        @element.add_attribute @command.name, "value"
        @command.on_element(@element)
        @element.attributes["foo"].should == "bar"
      end
    end
  end
end
