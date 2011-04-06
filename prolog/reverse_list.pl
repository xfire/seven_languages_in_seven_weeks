rev([], []) :- !.
rev([Head|Tail], RList) :- rev(Tail, RTail),
                           append(RTail, [Head], RList).

