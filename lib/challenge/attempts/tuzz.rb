class Tuzz < SomeonesAttempt
  X = :X

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
