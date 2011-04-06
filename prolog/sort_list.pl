% find all numbers smaller than X in list
smaller([], _, []) :- !.
smaller([H|T], X, [H|L]) :- smaller(T, X, L), H < X.
smaller([H|T], X, L) :- smaller(T, X, L), H >= X.

% find all numbers bigger than X in list
bigger([], _, []) :- !.
bigger([H|T], X, L) :- bigger(T, X, L), H < X.
bigger([H|T], X, [H|L]) :- bigger(T, X, L), H >= X.

% quick sort
sort_list([], []) :- !.
sort_list([H|T], S) :- smaller(T, H, SM),
                       bigger(T, H, BI), 

                       sort_list(SM, SSM),
                       sort_list(BI, SBI),

                       append(SSM, [H], P1), 
                       append(P1, SBI, S).
