require File.dirname(__FILE__) + '/../spec_helper'

describe AutoTagger::StageManager do

  describe ".new" do
    [nil, ""].each do |value|
      it "blows up if there are stages == #{value.inspect}" do
        proc do
          AutoTagger::StageManager.new(value)
        end.should raise_error(AutoTagger::StageManager::NoStagesSpecifiedError)
      end
    end
  end

  describe "#previous_stage" do
    it "returns the previous stage as a string if there is more than one stage, and there is a current stage" do
      AutoTagger::StageManager.new([:foo, :bar]).previous_stage(:bar).should == "foo"
    end

    it "returns nil if there is no previous stage" do
      AutoTagger::StageManager.new([:bar]).previous_stage(:bar).should be_nil
    end

    it "deals with mixed strings and symbols" do
      AutoTagger::StageManager.new([:"foo-bar", "baz"]).previous_stage(:baz).should == "foo-bar"
    end

    it "returns nil if there is no current stage" do
      AutoTagger::StageManager.new([:bar]).previous_stage(nil).should be_nil
    end
  end


end
