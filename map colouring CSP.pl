:- use_module(library(clpfd)).

solve_australia_coloring(Coloring) :-
    %1. Define the variables: one for each state/territory.
    % The variables names are uppercase , which is standard for Prolog.
    Coloring = [WA, NT, SA, QLD, NSW, VIC],

    %2. Define the domain for each variables (the available colors).
    % we use integer values to represent the collors: 1=red, 2=green, 3=blue.
    Coloring ins 1..3,

    %3. Define the constraints: adjacent states must have different colors.
    WA #\= NT,  %Western Australia must have a differet color than Nortern Territory.
    WA #\= SA,  %Western Australia must have a differet color than South Territory.
    NT #\= SA,
    NT #\= QLD,
    SA #\= QLD,
    SA #\= NSW,
    SA #\= VIC,
    QLD #\= NSW,
    NSW #\= VIC,

    %4. Find the first solutin by labeling the variables.
    % The 'labeling' predicates trigers the search for a solution.
    labeling([], Coloring).

%A helper predicates to display the solution in a more readable format.
display_coloring([WA, NT, SA, QLD, NSW, VIC]) :-

    format('Western Australia: ~w~n', [WA]),
    format('North Territory: ~w~n', [NT]),
    format('South Australia: ~w~n', [SA]),
    format('Queensland: ~w~n', [QLD]),
