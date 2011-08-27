require 'spec_helper'

module Rix
  module Commands
    describe AddElement do
      it "adds a new element" do
        command = AddElement.new
        command.name = "foo"
        command.value = "bar"
        element = Element.new
        command.on_element(element)
        element.elements[command.name].text.should == "bar"
      end
    end
  end
end
