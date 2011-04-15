checkPosition([]).
checkPosition([H|T]) :- member(H, [1,2,3,4,5,6,7,8]), checkPosition(T).

diag1([], []).
diag1([(X, Y)|T], [D|DT]) :- D is Y - X, diag1(T, DT).

diag2([], []).
diag2([(X, Y)|T], [D|DT]) :- D is Y + X, diag1(T, DT).

eight_queens(Board) :-
    Board = [(X1, Y1),
             (X2, Y2),
             (X3, Y3),
             (X4, Y4),
             (X5, Y5),
             (X6, Y6),
             (X7, Y7),
             (X8, Y8)],

    checkPosition([X1, X2, X3, X4, X5, X6, X7, X8,
                   Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8]),

    fd_all_different([X1, X2, X3, X4, X5, X6, X7, X8]),
    fd_all_different([Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8]),

    diag1(Board, D1),
    diag2(Board, D2),
    fd_all_different(D1),
    fd_all_different(D2).

%
%
% eight_queens([(1, A), (2, B), (3, C), (4, D), (5, E), (6, F), (7, G), (8, H)]).
%
%
