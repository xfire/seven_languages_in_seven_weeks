valid([]).
valid([H|T]) :- fd_all_different(H), valid(T).

split(Xs, N, H, T) :-
    length(H, N),
    append(H, T, Xs).

rows([], _, []) :- !.
rows(List, Size, [RHead|RTail]) :-
    append(RHead, Rest, List),
    length(RHead, Size),
    rows(Rest, Size, RTail).

column([], _, []) :- !.
column([H|T], N, [RHead|RTail]) :- 
    nth(N, H, RHead),
    column(T, N, RTail).

columns(_, 0, []) :- !.
columns(Rows, N, [RH|RT]) :-
    column(Rows, N, RH),
    NN is N - 1,
    columns(Rows, NN, RT).

flatten([], []) :- !.
flatten([H|T], R) :-
    append(H, X, R),
    flatten(T, X).

firstN(Zs, 0, [], Zs) :- !.
firstN([X|Xs], N, [X|Ys], Zs) :-
    N > 0,
    N1 is N - 1,
    split(Xs, N1, Ys, Zs).

rowParts([], _, []) :- !.
rowParts([Row|RowTail], X, [RH|RT]) :-
    rows(Row, X, RH),
    rowParts(RowTail, X, RT).

squareCols(_, 0, _, _, []) :- !.
squareCols(RowParts, Xn, X, Y, [SH|ST]) :-
    squareRows(RowParts, Xn, X, Y, SH),
    Xnn is Xn - 1,
    squareCols(RowParts, Xnn, X, Y, ST).

squareRows([], _, _, _, []) :- !.
squareRows(RowParts, N, X, Y, [SH|ST]) :-
    firstN(RowParts, Y, Rows, RowPartsRest),
    column(Rows, N, Cols),
    flatten(Cols, SH),
    squareRows(RowPartsRest, N, X, Y, ST).

squares(Rows, Xn, XLen, YLen, Squares) :-
    rowParts(Rows, XLen, RowParts),
    squareCols(RowParts, Xn, XLen, YLen, SS),
    flatten(SS, Squares).

pprint(Xs, N) :-
    firstN(Xs, N, H, T),
    write(H), write('\n'),
    pprint(T, N).


sudoku(Puzzle, Solution) :-
    length(Puzzle, 16),
    sudoku(Puzzle, 4, 2, 2, 2, Solution).

sudoku(Puzzle, Solution) :-
    length(Puzzle, 36),
    sudoku(Puzzle, 6, 2, 3, 2, Solution).

sudoku(Puzzle, Solution) :-
    length(Puzzle, 81),
    sudoku(Puzzle, 9, 3, 3, 3, Solution).

sudoku(Puzzle, N, CellLen, CellX, CellY, Solution) :- 
    Solution = Puzzle,

    fd_domain(Puzzle, 1, N),
    fd_labelingff(Puzzle),

    rows(Puzzle, N, Rows),
    columns(Rows, N, Columns),
    squares(Rows, CellLen, CellX, CellY, Squares),
    
    append(Rows, Columns, X),
    append(X, Squares, AllParts),
    valid(AllParts),

    pprint(Solution, N).

test1(S) :-
    P = [_,_,2,3,
         _,_,_,_,
         _,_,_,_,
         3,4,_,_],
    sudoku(P, S).

test2(S) :-
	P = [_,6,_,1,_,4,_,5,_,
	     _,_,8,3,_,5,6,_,_,
	     2,_,_,_,_,_,_,_,1,
	     8,_,_,4,_,7,_,_,6,
	     _,_,6,_,_,_,3,_,_,
	     7,_,_,9,_,1,_,_,4,
	     5,_,_,_,_,_,_,_,2,
	     _,_,7,2,_,6,9,_,_,
	     _,4,_,5,_,8,_,7,_],
	sudoku(P, S).

test3(S) :-
	P = [_,_,4 ,_,_,3, _,7,_,
	     _,8,_ ,_,7,_, _,_,_,
	     _,7,_ ,_,_,8, 2,_,5,
	     4,_,_ ,_,_,_, 3,1,_,
	     9,_,_ ,_,_,_, _,_,8,
	     _,1,5 ,_,_,_, _,_,4,
	     1,_,6 ,9,_,_, _,3,_,
	     _,_,_ ,_,2,_, _,6,_,
	     _,2,_ ,4,_,_, 5,_,_],
	sudoku(P, S).

test4(S) :-
	P = [_,4,3,_,8,_,2,5,_,
         6,_,_,_,_,_,_,_,_,
         _,_,_,_,_,1,_,9,4,
         9,_,_,_,_,4,_,7,_,
         _,_,_,6,_,8,_,_,_,
         _,1,_,2,_,_,_,_,3,
         8,2,_,5,_,_,_,_,_,
         _,_,_,_,_,_,_,_,5,
         _,3,4,_,9,_,7,1,_],
	sudoku(P, S).

test5(S) :-
	P = [8,_,3,_,2,9,7,1,6,
         _,_,6,_,1,8,5,_,4,
         _,_,_,_,6,_,_,_,8,
         _,_,5,_,4,6,_,8,_,
         7,_,9,_,3,5,6,4,2,
         _,6,_,_,9,_,1,_,5,
         6,_,_,_,7,_,_,5,1,
         _,_,1,6,5,_,8,_,_,
         5,_,_,9,8,1,4,6,3],
	sudoku(P, S).

test6(S) :-
	P = [_,_,_,1,5,_,_,7,_,
         1,_,6,_,_,_,8,2,_,
         3,_,_,8,6,_,_,4,_,
         9,_,_,4,_,_,5,6,7,
         _,_,4,7,_,8,3,_,_,
         7,3,2,_,_,6,_,_,4,
         _,4,_,_,8,1,_,_,9,
         _,1,7,_,_,_,2,_,8,
         _,5,_,_,3,7,_,_,_],
	sudoku(P, S).

