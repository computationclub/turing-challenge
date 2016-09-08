## Turing Challenge

After the (nascent) London Computation Club met in 2013 to discuss the Turing
Machines chapter of Understanding Computation, I sent this challenge to the
book’s mailing list:

> Design a Turing machine to compute the function f(n) = the smallest k such
that 2^k > n. For example, f(13) = 4, because 2^4 = 16 and 16 > 13 (but 2^3 = 8
and 8 ≯ 13). You can pick whatever input representation you like, but you should
use the same representation for the output.
>
> The interesting parts are:
>
> 1. Is there a more intuitive way to describe what this function does?
> 2. How few DTM states, rules and symbols do you need to compute it?
> 3. What's the simplest input representation?
>
> By all means send any solutions to the list so that everyone can bask in your
achievement. Bonus points for executable implementations, obvs.

I think it’s a fun and instructive problem, so if you enjoyed last night’s
“increment a binary number”, you might enjoy this too!

Cheers,

-Tom

## How do I add my attempt?

1. Add a class to `lib/challenge/attempts/`
2. Make your class subclass `SomeonesAttempt`
3. Implement the `#turing_machine_description` method
4. Require your class in `lib/challenge.rb`
5. Add a rake task to the `Rakefile` and run it

There's more information in `lib/challenge/someones_attempt.rb`

## Thanks

Thanks to ~~[Tom Stuart](https://twitter.com/tomstuart)~~ [Ken Moody](http://www.cl.cam.ac.uk/teaching/0708/CompTheory/Tm-ex1.pdf) for thinking up the
challenge and to [James Coglan](https://twitter.com/mountain_ghosts) for
implementing `lib/challenge/turing.rb` which is used in this test harness.
