require 'spec_helper'

module Rix
  module Commands
    describe Trim do
      before do
        @command = Trim.new
        @element = Element.new "element"
      end

      it "trims elements" do
        @element.text = " x "
        result =  @command.on_element @element
        result.should == "x"
      end

      it "trims text nodes" do
        text = Text.new(" x ")
        @element.add text
        result =  @command.on_text text
        result.should == "x"
      end

      it "trims attributes" do
        attribute = Attribute.new("name", " value ")
        @element.add_attribute attribute
        result =  @command.on_attribute attribute
        result.should == "value"
      end
    end
  end
end
