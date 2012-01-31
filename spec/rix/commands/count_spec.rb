require 'spec_helper'

module Rix
  module Commands
    describe Count do
      before do
        @out = StringIO.new
        command = Count.new
        command.out = @out
        # String has a size method, so we use that for the 'nodes' parameter
        command.before("name", nil, "123")
      end

      it "writes the name to the output" do
        @out.string.should match(/^name/)
      end

      it "writes the number of selected nodes to the output" do
        @out.string.should match(/3$/)
      end
    end
  end
end
