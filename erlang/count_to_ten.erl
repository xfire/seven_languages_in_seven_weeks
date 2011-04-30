-module(count_to_ten).
-export([count_to_ten/0]).

count_to_ten() -> count_to_ten(1).

count_to_ten(N) when N < 10 ->
    io:format("~w~n", [N]),
    count_to_ten(N + 1);
count_to_ten(N) -> N.
