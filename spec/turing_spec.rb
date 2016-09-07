require "spec_helper"

RSpec.describe Turing do
  it "runs the example program that increments a binary number" do
    increment = Turing::Machine.new([
      [1, 0, 1, :R, 2],
      [1, 1, 0, :L, 1],
      [1, B, 1, :R, 2],
      [2, 0, 0, :R, 2],
      [2, 1, 1, :R, 2],
      [2, B, B, :L, 3]
    ])

    increment.write_tape [1, 0, 1, 1]
    increment.set_state 1

    increment.run

    expect(increment.read_tape).to eq [1, 1, 0, 0]
  end
end
