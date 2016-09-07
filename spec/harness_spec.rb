require "spec_helper"

RSpec.describe Harness do
  it "outputs failures to stdout" do
    expect {
      Harness.run(SomeonesAttempt.new, numbers_to_test: 1..3)
    }.to output(/input 1 returned 2, expected 1/).to_stdout
  end
end
