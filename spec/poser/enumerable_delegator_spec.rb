require 'spec_helper'

describe Poser::EnumerableMimicker do
  subject { described_class.new @presentee, @context }

  before do
    @presentee = mock Object
    @context = mock Object
  end

  it { should be_a(Poser::Mimicker) }

  describe "each" do
    it "yields each object presented" do
      @presentee = [Object.new, Object.new]

      yielded_objects = []
      subject.each do |obj|
        yielded_objects << obj
      end

      yielded_objects.should == [
        subject.present(@presentee[0]),
        subject.present(@presentee[1])
      ]
    end
  end

end