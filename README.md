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

## Thanks

Thanks to [Tom Stuart](https://twitter.com/tomstuart) for thinking up the
challenge and to [James Coglan](https://twitter.com/mountain_ghosts) for
implementing `lib/challenge/turing.rb` which is used in this test harness.
