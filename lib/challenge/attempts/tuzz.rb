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
end
