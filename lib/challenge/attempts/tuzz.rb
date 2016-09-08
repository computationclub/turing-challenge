class Tuzz
  X = :X

  # This attempt was my first pass at a solution. The program scans over the
  # binary string then starts to mark each digit off with Xs whilst incrementing
  # another binary number to the left.
  #
  # This attempt follows the calling convention that the tape must only contain
  # the binary result (no other symbols) and the head must finish on the
  # right-most digit of the result.
  class V1 < SomeonesAttempt
    def turing_machine_description
      [
        # scan left until the blank is reached
        [1, 0, 0, :L, 1],
        [1, 1, 1, :L, 1],
        [1, B, B, :R, 2],

        # mark the leftmost digit as an X
        [2, 0, X, :L, 3],
        [2, 1, X, :L, 3],
        [2, X, X, :R, 2],

        # if no more digits start to tidy up
        [2, B, B, :L, 4],

        # scan left until the blank is reached
        [3, X, X, :L, 3],
        [3, B, B, :L, 4],

        # increment the binary number
        [4, 0, 1, :R, 5],
        [4, 1, 0, :L, 4],
        [4, B, 1, :R, 5],

        # scan right until the blank is reached
        [5, 0, 0, :R, 5],
        [5, 1, 1, :R, 5],
        [5, B, B, :R, 2],

        # remove all Xs to tidy up
        [6, X, B, :L, 6],

        # halt on the rightmost digit
        [6, B, B, :L, 7],
      ]
    end
  end

  # This attempt is similar but it reduces the number of states by one at the
  # expense of an additional symbol 'R' and an additional rule. The 'R' symbol
  # is written over the blank in the middle and it determines the direction
  # the machine should move next, rather than this being two states.
  class V2 < SomeonesAttempt
    R = :R

    def turing_machine_description
      [
        # scan left
        [1, 0, 0, :L, 1],
        [1, 1, 1, :L, 1],
        [1, X, X, :L, 1],

        # if a blank is found, go right
        [1, B, R, :R, 2],

        # if an R is found, go left
        [1, R, B, :L, 3],

        # mark the leftmost digit as an X
        [2, 0, X, :L, 1],
        [2, 1, X, :L, 1],
        [2, X, X, :R, 2],

        # if no more digits start to tidy up
        [2, B, B, :L, 5],

        # increment the binary number
        [3, 0, 1, :R, 4],
        [3, 1, 0, :L, 3],
        [3, B, 1, :R, 4],

        # scan right
        [4, 0, 0, :R, 4],
        [4, 1, 1, :R, 4],

        # if a blank is found, go right
        [4, B, R, :R, 2],

        # if an R is found, go left
        [4, R, B, :L, 3],

        # remove all Xs and the R to tidy up
        [5, X, B, :L, 5],
        [5, R, B, :L, 6],
      ]
    end
  end

  # This attempt is quite different from the others. It only uses three states
  # at the expense of more symbols. It uses different symbols from the binary
  # number under construction to differentiate it from the one being counted.
  # There's a "clean up" step at the end in which the Xs are removed and the
  # Ys are replaced with 1s and the Zs with zeroes, which ensures the
  # representation of the output matches the input.
  #
  # Originally, I tried doing this with two states and changed the
  # representation so that there was a marker on the left and right of the input
  # number, but couldn't get it to work. Oh well!
  class V3 < SomeonesAttempt
    M = :M
    Y = :Y
    Z = :Z

    def turing_machine_description
      [
        # immediately mark a digit
        [1, 0, X, :L, 2],
        [1, 1, X, :L, 2],

        # scan left
        [2, 0, 0, :L, 2],
        [2, 1, 1, :L, 2],

        # increment binary number
        # this uses Z=0, Y=1 instead of 0 and 1 to differentiate this binary
        # from the one that we're counting digits
        [2, B, Y, :R, 1],
        [2, Y, Z, :L, 2],
        [2, Z, Y, :R, 1],

        # scan right
        [1, Y, Y, :R, 1],
        [1, Z, Z, :R, 1],

        # skip over Xs depending on the direction of travel
        [1, X, X, :R, 1],
        [2, X, X, :L, 2],

        # start tidying up when we reach the end
        # leave a marker so we know we're done when we return here
        [1, B, M, :L, 3],

        # remove Xs
        [3, X, B, :L, 3],

        # replace Y with 1 and Z with 0
        [3, Y, 1, :L, 3],
        [3, Z, 0, :L, 3],

        # turn around when we reach the other end
        [3, B, B, :R, 3],

        # scan right
        [3, 0, 0, :R, 3],
        [3, 1, 1, :R, 3],

        # replace the marker with a blank and we're done!
        [3, M, B, :L, 4],
      ]
    end
  end

  # This is a 2 state turing machine that solves this problem!
  # My whiteboard has never seen so much action.
  class V4inImaginings < SomeonesAttempt
    A = :A
    C = :C
    L = :L
    M = :M
    R = :R
    Y = :Y
    Z = :Z

    def turing_machine_description
      [
        # toggle 'L' to 'M'
        # we do this so we know which direction to travel when we return
        [1, L, M, :R, 1],

        # mark a digit and switch states
        [1, 0, X, L, 2],
        [1, 1, X, L, 2],

        # when we reach the middle, switch states and toggle again
        [2, M, L, L, 1],

        # increment the binary number
        # we use different symbols from 0 and 1 to differentiate state
        # when travelling left, we A=0, when travelling right we use Z=0
        # this lets us remain in state 0 without having to switch
        [1, B, Y, R, 1],
        [1, Y, A, L, 1],
        [1, Z, Y, R, 1],
        [1, A, Z, R, 1],

        # scan right using the same trick to remember direction
        # in this case X means we're going right, C means 'cleanup'
        [1, X, C, R, 1],

        # if we're in state 2, we need to reset cleanup symbols
        [2, C, X, L, 2],

        # when we reach the right-hand side, start cleaning up
        [1, R, B, L, 1],
        [1, C, B, L, 1],

        # when we reach the middle, switch states
        # we set M to R here because this is going to be the right-hand side
        [1, M, R, L, 2],

        # swap Ys for 1s and Zs for 0s
        [2, Y, 1, L, 2],
        [2, Z, 0, L, 2],

        # when we reach the left-hand side, write the L symbol
        [2, B, L, R, 2],
      ]
    end

    # the representation is identical except we wrap the input with a L on the
    # left and an R on the right.
    def encode(input)
      [L] + super + [R]
    end

    # we have to make sure the output representation matches that of the input:
    #
    # from the readme:
    #
    # > You can pick whatever input representation you like, but you should use
    # > the same representation for the output.
    #
    # therefore, we raise an error if the representation is invalid
    def decode(final_tape)
      final_tape = final_tape.dup

      l = final_tape.shift
      r = final_tape.pop

      raise "invalid representation" unless l == L && r == R

      super(final_tape)
    end
  end
end
