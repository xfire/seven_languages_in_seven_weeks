smallest([A], A) :- !.
smallest([H|T], S) :- smallest(T, S), H >= S.
smallest([H|T], H) :- smallest(T, S2), H < S2.
