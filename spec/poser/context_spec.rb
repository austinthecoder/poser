require 'spec_helper'

describe Poser::Context do
  subject { Class.new { include Poser::Context }.new }

  describe "instance methods" do
    describe "present" do
      before do
        @object = Object.new
        @result = Object.new
      end

      it "returns the result of telling Poser::Mimicker to present the given object in the given context" do
        cntxt = Object.new
        Poser::Mimicker.stub(:present) do |object, context|
          @result if object == @object && context == cntxt
        end

        subject.present(@object, cntxt).should == @result
      end

      it "returns the result of telling Poser::Mimicker to present the given object, using itself as the context when a context isn't given" do
        Poser::Mimicker.stub(:present) do |object, context|
          @result if object == @object && context == subject
        end

        subject.present(@object).should == @result
      end
    end
  end
end