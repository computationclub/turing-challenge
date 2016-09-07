module Harness
  def self.run(someones_attempt, numbers_to_test: 1..100)
    machine = Turing::Machine.new(
      someones_attempt.turing_machine_description
    )

    errors = []
    numbers_to_test.each do |input|
      initial_tape = someones_attempt.encode(input)

      machine.write_tape initial_tape.dup
      machine.set_state 1
      machine.run

      final_tape = machine.read_tape
      output = someones_attempt.decode(final_tape)
      expected = Math.log2(input + 1).ceil

      unless output == expected
        errors.push(
          input: input,
          expected: expected,
          actual: output,
          initial_tape: initial_tape,
          final_tape: final_tape,
        )
      end
    end

    if errors.empty?
      puts "All passed, congrats!"
    else
      errors.each do |error|
        puts "failure:"
        puts "input #{error[:input]} returned #{error[:actual]}, expected #{error[:expected]}"
        puts "  initial tape: #{error[:initial_tape].inspect}"
        puts "  final tape: #{error[:final_tape].inspect}"
        puts
      end
    end
  end
end
