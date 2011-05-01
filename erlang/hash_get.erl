-module(hash_get).
-export([get/2, get2/2]).

get([], _) -> undefined;
get(Xs, Term) -> lists:foldl(
    fun(Val, Acc) ->
        {K, V} = Val,
        if
            K == Term -> V;
            true -> Acc
        end
    end,
    undefined, Xs).

get2([], _) -> undefined;
get2(Xs, Term) -> head([V || {K, V} <- Xs, K == Term]).

head([]) -> undefined;
head([H | _]) -> H.
