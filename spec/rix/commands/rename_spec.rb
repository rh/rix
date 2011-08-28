require 'spec_helper'

module Rix
  module Commands
    describe Rename do
      it "renames elements" do
        command = Rename.new
        command.name = "after"
        element = Element.new "before"
        element.name.should == "before"
        command.on_element(element)
        element.name.should == command.name
      end

      it "renames attributes" do
        command = Rename.new
        command.name = "after"
        attribute = Attribute.new "before"
        attribute.name.should == "before"
        command.on_attribute(attribute)
        attribute.name.should == command.name
      end
    end
  end
end
