require 'spec_helper'

module Rix
  module Commands
    describe Set do
      before(:each) do
        @command = Set.new
        @command.value = "after"
        @element = Element.new "element"
        @element.text = "before"
        @attribute = Attribute.new("attribute", "before")
        @element.add_attribute @attribute
      end

      it "sets the value of an element" do
        @command.on_element(@element)
        @element.text.should == "after"
      end

      it "sets the value of an attribute" do
        result = @command.on_attribute(@attribute)
        result.to_s.should == "after"
      end

      it "sets the value of text nodes" do
        text = Text.new("before")
        @element.add text
        result =  @command.on_text text
        result.should == "after"
      end

      it "clears the value of an element" do
        command = Set.new
        element = Element.new "element"
        command.on_element(element)
        element.text.should == ""
      end

      it "clears the value of an attribute" do
        command = Set.new
        element = Element.new "element"
        attribute = Attribute.new("attribute", "before")
        element.add_attribute attribute
        result = command.on_attribute(attribute)
        result.to_s.should == ""
      end

      it "clears the value of text nodes" do
        command = Set.new
        element = Element.new "element"
        attribute = Attribute.new("attribute", "before")
        element.add_attribute attribute
        text = Text.new("before")
        element.add text
        result = command.on_text(text)
        result.should == ""
      end
    end
  end
end
