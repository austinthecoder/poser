require 'spec_helper'

describe Poser::Presentable do
  before(:all) { C = Class.new { include Poser::Presentable } }
  after(:all) { Object.send :remove_const, :C }

  describe "class methods" do
    subject { C }

    describe "presenter_class" do
      after :all do
        Object.send :remove_const, :CPresenter
        C.send :remove_const, :Presenter
      end

      it "returns Poser::Presenter when no presenter classes are available for this class" do
        subject.presenter_class.should == Poser::Presenter
      end

      it "returns CPresenter if it exists" do
        CPresenter = Class.new
        subject.presenter_class.should == CPresenter
      end

      it "returns the Presenter class namespaced under this class if it exists" do
        C::Presenter = Class.new
        subject.presenter_class.should == C::Presenter
      end
    end
  end

  describe "instance methods" do
    subject { C.new }

    describe "to_presenter" do
      it "presents itself within the context given using the appropriate class" do
        context = Object.new
        c = Class.new Poser::Presenter
        C.stub(:presenter_class) { c }
        subject.to_presenter(context).should == c.new(subject, context)
      end
    end
  end
end