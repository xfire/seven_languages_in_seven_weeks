count([], 0).
count([_|Tail], Count) :- count(Tail, TailCount), Count is TailCount + 1.

sum([], 0).
sum([Head|Tail], Sum) :- sum(Tail, TailSum), Sum is TailSum + Head.

avg([], 0).
avg(List, Avg) :- sum(List, Sum), count(List, Count), Avg is Sum / Count.
