require 'forwardable'

module Turing
  BLANK = Class.new {
    def inspect
      '<Blank>'
    end

    def to_s
      '_'
    end
  }.new

  class Tape
    def initialize(contents)
      @left  = contents
      @right = []
    end

    def read
      @left.last || BLANK
    end

    def write(value)
      @left.pop
      push(@left, value)
    end

    def move_left
      push(@right, @left.pop)
    end

    def move_right
      push(@left, @right.pop)
    end

    def inspect
      left  = @left.dup
      last  = left.pop || BLANK
      cells = left + ["[#{ last }]"] + @right.reverse

      "<Tape: #{ cells * ' ' }>"
    end

    def to_a
      @left + @right.reverse
    end

  private

    def push(list, value)
      value ||= BLANK
      list.push(value) unless value == BLANK and list.empty?
    end
  end

  class Machine
    Key    = Struct.new(:state, :symbol)
    Result = Struct.new(:symbol, :motion, :state)

    extend Forwardable
    def_delegators :@tape, :read, :write, :move_left, :move_right

    def initialize(instructions, start_state = nil, tape_contents = [])
      @instructions = {}

      instructions.each do |current_state, current_symbol, new_symbol, motion, new_state|
        key    = Key.new(current_state, current_symbol)
        result = Result.new(new_symbol, motion, new_state)

        @instructions[key] = result
      end

      set_state(start_state)
      write_tape(tape_contents)
    end

    def set_state(new_state)
      @state = new_state
    end

    def write_tape(contents)
      @tape = Tape.new(contents)
    end

    def read_tape
      @tape.to_a
    end

    def run
      loop { break unless execute_instruction }
    end

    def execute_instruction
      result = @instructions[Key.new(@state, read)]
      return unless result

      write(result.symbol)
      set_state(result.state)

      case result.motion
      when :L then move_left
      when :R then move_right
      end

      result
    end

    def inspect
      "<Machine: {#{ @state }} #{ @tape.inspect }>"
    end
  end
end
