require "spec_helper"

RSpec.describe SomeonesAttempt do
  describe "#encode" do
    it "encodes a number as binary" do
      expect(subject.encode(14)).to eq [1, 1, 1, 0]
      expect(subject.encode(15)).to eq [1, 1, 1, 1]
      expect(subject.encode(16)).to eq [1, 0, 0, 0, 0]
    end
  end

  describe "#decode" do
    it "decodes a binary number" do
      expect(subject.decode([1, 1, 1, 0])).to eq(14)
      expect(subject.decode([1, 1, 1, 1])).to eq(15)
      expect(subject.decode([1, 0, 0, 0, 0])).to eq(16)
    end
  end
end
