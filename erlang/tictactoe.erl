-module(tictactoe).
-export([state/1]).

state(Board) when length(Board) == 9 ->
    Winner = winner(Board),
    Draw = draw(Board),
    if
        Winner /= no_winner -> Winner;
        Draw -> cat;
        true -> no_winner
    end.

% i'm to lazy today...
% but the guards really sucks... :/
winner([P,P,P | _]) when (P == x) or (P == o) -> P;
winner([_,_,_,
        P,P,P | _]) when (P == x) or (P == o) -> P;
winner([_,_,_,
        _,_,_,
        P,P,P]) when (P == x) or (P == o) -> P;
winner([P,_,_,
        _,P,_,
        _,_,P]) when (P == x) or (P == o) -> P;
winner([_,_,P,
        _,P,_,
        P,_,_]) when (P == x) or (P == o) -> P;
winner([P,_,_,
        P,_,_,
        P,_,_]) when (P == x) or (P == o) -> P;
winner([_,P,_,
        _,P,_,
        _,P,_]) when (P == x) or (P == o) -> P;
winner([_,_,P,
        _,_,P,
        _,_,P]) when (P == x) or (P == o) -> P;
winner(_) -> no_winner.

draw(Board) -> lists:all(fun(N) -> (N == o) or (N == x) end, Board).
