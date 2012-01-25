require 'spec_helper'

module Rix
  module Commands
    describe Set do
      before(:all) do
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
    end
  end
end
