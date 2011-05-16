require 'spec_helper'

module Rix
  describe Command do
    describe ".description" do
      before(:all) do
        class Foo < Command
          description 'foo'
        end
      end

      it "adds a description" do
        Foo.should respond_to(:description)
      end

      it "sets a description" do
        Foo.description.should == 'foo'
      end
    end
  end
end
