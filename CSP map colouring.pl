:- use_module(library(clpfd)).

solve_australia_coloring(Coloring):-

    %1.Define the variable .
    Coloring = [WA,NT,SA,QLD,NSW,VIC],

    %2.Define the domain for each variable.
    Coloring ins 1..3,
`
    %3.Define the constraints.

    WA #\= NT,
    WA #\= SA,
    NT #\= SA,
    NT #\= QLD,
    SA #\= QLD,
    SA #\= NSW,
    SA #\= VIC,

    %4,Find the first solution by labelling the variables.

   labeling([],Coloring).

%A helper predicate to display the solution in more readable format.
display_coloring([WA, NT, SA, QLD, NSW, VIC]):-

    format('Western Australia: ~w~n',[WA]),
    format('Northern Territory: ~w~n',[NT]),
    format('South Australia: ~w~n',[SA]),
    format('Queensland: ~w~n',[QLD]),
    format('New South Wales: ~w~n',[NSW]),
    format('Victoria: ~w~n',[VIC]).
