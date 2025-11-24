 :- use_module(library(lists)).   % permutations/2

% queens(Qs) - Qs is a list of 8 integers; element
queens(Qs) :-
    permutation([1,2,3,4,5,6,7,8], Qs),
    safe(Qs).

% safe(List) - no two queens attack each other diagonally
safe([]).
safe([Q|Qs]) :-
    no_attack(Q, Qs, 1),
    safe(Qs).

% no_attack(Q, Rest, D) - Q doesn't attack any element of rest;
% D is the column distance between Q and the head of Rest (1 for
% adjacent column).
no_attack(_, [], _).
no_attack(Q, [Q1|Qs], D) :-
    Q =\= Q1,
    abs(Q - Q1) =\= D,

    D1 is D + 1,
    no_attack(Q, Qs, D1).

% optional: print a human-readable board for solution Qs

print_Board(Qs) :-
    length(Qs, N),
    print_rows(N, Qs).

print_rows(0, _).
print_rows(Row, Qs) :-
    Row > 0,
    print_cols(1, Row, Qs),
    nl,
    Row1 is Row - 1,
    print_rows(Row1, Qs).

print_cols(Col, Row, Qs) :-
    length(Qs, N),
    (   Col > N -> true
    ;   nth1(Col, Qs, R),
        (   R =:= Row -> write('Q ') ; write('. ') ),
        Col1 is Col + 1,
        print_cols(Col1, Row, Qs)
    ).




