-module(shopping_list).
-export([total_price/1]).

total_price(Xs) -> [{I, Q * P} || {I, Q, P} <- Xs].
