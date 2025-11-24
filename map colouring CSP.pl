:- use_module(library(clpfd)).

solve_australia_coloring(Coloring) :-
    Coloring = [WA, NT, SA, QLD, NSW, VIC],
    Coloring ins 1..3,
    WA #\= NT,
    WA #\= SA,
    NT #\= SA,
    NT #\= QLD,
    SA #\= QLD,
    SA #\= NSW,
    SA #\= VIC,
    QLD #\= NSW,
    NSW #\= VIC,
    labeling([], Coloring).

display_coloring([WA, NT, SA, QLD, NSW, VIC]) :-
    format('Western Australia: ~w~n', [WA]),
    format('North Territory: ~w~n', [NT]),
    format('South Australia: ~w~n', [SA]),
    format('Queensland: ~w~n', [QLD]),
    format('New South Wales: ~w~n', [NSW]),
    format('Victoria: ~w~n', [VIC]).
