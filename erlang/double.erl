-module(double).
-export([double/1]).

double([]) -> [];
double([H|T]) -> [H, H | double(T)].
