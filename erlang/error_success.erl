-module(error_success).
-export([some_func/1]).

some_func(success) -> io:format("success~n");
some_func({error, Message}) -> io:format("error: ~s~n", [Message]).
