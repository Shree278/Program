% alpha_beta(+Position, +Alpha, +Beta, +Player, -BestValue)
% Simple demonstration of Alpha-Beta pruning.
% Base case: if leaf node, evaluate position
alpha_beta(Position, _, _, _, Value) :-
 terminal(Position),           % no more moves
 value(Position, Value),!.     % evaluate leaf

% Recursive case: maximizing player
alpha_beta(Position, Alpha, Beta, max, BestValue) :-
 findall(Move, move(Position, Move), Moves),
 evaluate_moves(Moves, Position, Alpha, Beta, max, -inf, BestValue).

% Recursive case: minimizing player
alpha_beta(Position, Alpha, Beta, min, BestValue) :-
 findall(Move, move(Position, Move), Moves),
 evaluate_moves(Moves, Position, Alpha, Beta, min, inf, BestValue).

% Evaluate all possible moves with pruning
evaluate_moves([], _, _, _, _, Value, Value).
evaluate_moves([Move|Moves], Position, Alpha, Beta, max, CurBest, BestValue)
:-
 apply(Position, Move, NewPos),
 alpha_beta(NewPos, Alpha, Beta, min, Value),
 NewAlpha is max(Alpha, Value),
 ( NewAlpha >= Beta -> BestValue = NewAlpha   % prune
 ; max(CurBest, Value, NextBest),
 evaluate_moves(Moves, Position, NewAlpha, Beta, max, NextBest, BestValue)
 ).

 evaluate_moves([Move|Moves], Position, Alpha, Beta, min, CurBest, BestValue)
:-
    apply(Position, Move, NewPos),
    alpha_beta(NewPos, Alpha, Beta, max, Value),
    NewBeta is min(Beta, Value),
    ( Alpha >= NewBeta -> BestValue = NewBeta   % prune
    ; min(CurBest, Value, NextBest),
      evaluate_moves(Moves, Position, Alpha, NewBeta, min, NextBest, BestValue)
    ).

% --- Example game setup (tiny tree for demo) ---
% terminal states
terminal(a).
terminal(b).
terminal(c).
terminal(d).

% possible moves
move(root, a).
move(root, b).
move(a, c).
move(a, d).

% apply move
apply(_, Move, Move).

% values at leaves
value(a, 3).
value(b, 12).
value(c, 8).
value(d, 2).

% helper: max/min comparison
max(A,B,B) :- B >= A, !.
max(A,_,A).
min(A,B,B) :- B =< A, !.
min(A,_,A).
