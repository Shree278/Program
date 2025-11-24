alpha_beta(Position, _, _, _, Value) :-
    terminal(Position),
    value(Position, Value), !.

alpha_beta(Position, Alpha, Beta, max, BestValue) :-
    findall(Move, move(Position, Move), Moves),
    evaluate_moves(Moves, Position, Alpha, Beta, max, -inf, BestValue).

alpha_beta(Position, Alpha, Beta, min, BestValue) :-
    findall(Move, move(Position, Move), Moves),
    evaluate_moves(Moves, Position, Alpha, Beta, min, inf, BestValue).

evaluate_moves([], _, _, _, _, Value, Value).
evaluate_moves([Move|Moves], Position, Alpha, Beta, max, CurBest, BestValue) :-
    apply(Position, Move, NewPos),
    alpha_beta(NewPos, Alpha, Beta, min, Value),
    NewAlpha is max(Alpha, Value),
    ( NewAlpha >= Beta ->
        BestValue = NewAlpha
    ; max(CurBest, Value, NextBest),
      evaluate_moves(Moves, Position, NewAlpha, Beta, max, NextBest, BestValue)
    ).

evaluate_moves([Move|Moves], Position, Alpha, Beta, min, CurBest, BestValue) :-
    apply(Position, Move, NewPos),
    alpha_beta(NewPos, Alpha, Beta, max, Value),
    NewBeta is min(Beta, Value),
    ( Alpha >= NewBeta ->
        BestValue = NewBeta
    ; min(CurBest, Value, NextBest),
      evaluate_moves(Moves, Position, Alpha, NewBeta, min, NextBest, BestValue)
    ).

terminal(a).
terminal(b).
terminal(c).
terminal(d).

move(root, a).
move(root, b).
move(a, c).
move(a, d).

apply(_, Move, Move).

value(a, 3).
value(b, 12).
value(c, 8).
value(d, 2).

max(A, B, B) :- B >= A, !.
max(A, _, A).

min(A, B, B) :- B =< A, !.
min(A, _, A).
