require 'spec_helper'

describe Poser::Presenter do
  describe "class methods" do
    subject { described_class }

    describe "present" do
      before do
        @object = mock Object
        @context = Object.new
      end

      it "returns the object if it's presented" do
        @object.stub(:presented?) { true }
        subject.present(@object, @context).should == @object
      end

      it "returns the result of the object presenting itself if it knows how" do
        result = Object.new
        @object.stub(:to_presenter) { result }
        subject.present(@object, @context).should == result
      end

      it "otherwise returns an instance of itself" do
        subject.present(@object, @context).should == subject.new(@object, @context)
      end
    end
  end

  describe "instance methods" do
    subject { described_class.new @presentee, @context }

    before do
      @presentee = Object.new
      @context = Object.new
    end

    it { should be_presented }
    its(:context) { should == @context }

    describe "==" do
      it "is true given a #{described_class} instantiated with the same presentee and context" do
        subject.should == described_class.new(@presentee, @context)
      end

      it "is not true given a non-#{described_class}" do
        subject.should_not == Object.new
      end

      it "is not true given a #{described_class} with a different presentee" do
        subject.should_not == described_class.new(Object.new, @context)
      end

      it "is not true given a #{described_class} with a different context" do
        subject.should_not == described_class.new(@presentee, Object.new)
      end
    end

    describe "present" do
      it "returns the result of telling the #{described_class} to present the given object with the same context" do
        result = Object.new
        object = Object.new

        described_class.stub :present do |presentee, context|
          result if presentee == object && context == @context
        end

        subject.present(object).should == result
      end
    end

    describe "class" do
      it "delegates to the presenter" do
        @presentee.stub(:class) { String }
        subject.class.should == String
      end
    end
  end
end