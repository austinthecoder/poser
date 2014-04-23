require 'spec_helper'

describe Poser::Delegatable do
  before(:all) { C = Class.new { include Poser::Delegatable } }
  after(:all) { Object.send :remove_const, :C }

  describe "class methods" do
    subject { C }

    describe "delegator_class" do
      before { subject.delegator_class = nil }

      it "returns Poser::Mimicker when no delegator classes are available for this class" do
        subject.delegator_class.should == Poser::Mimicker
      end

      it "returns CMimicker if it exists" do
        CMimicker = Class.new
        subject.delegator_class.should == CMimicker
        Object.send :remove_const, :CMimicker
      end

      it "returns the Mimicker class namespaced under this class if it exists" do
        CMimicker = Class.new
        C::Mimicker = Class.new
        subject.delegator_class.should == C::Mimicker
        C.send :remove_const, :Mimicker
        Object.send :remove_const, :CMimicker
      end
    end
  end

  describe "instance methods" do
    subject { C.new }

    describe "to_delegator" do
      it "presents itself within the context given using the appropriate class" do
        context = Object.new
        c = Class.new Poser::Mimicker
        C.stub(:delegator_class) { c }
        subject.to_delegator(context).should == c.new(subject, context)
      end
    end
  end
end