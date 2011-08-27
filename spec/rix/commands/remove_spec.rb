require 'spec_helper'

module Rix
  module Commands
    describe Remove do
      it "removes elements" do
        command = Remove.new
        parent = Element.new "parent"
        child = Element.new "child"
        parent.add_element(child)
        parent.has_elements?.should == true
        command.on_element(child)
        parent.has_elements?.should == false
      end

      it "removes attributes" do
        command = Remove.new
        element = Element.new "element"
        attribute = Attribute.new "name", "value"
        element.add_attribute(attribute)
        element.has_attributes?.should == true
        command.on_attribute(attribute)
        element.has_attributes?.should == false
      end
    end
  end
end
