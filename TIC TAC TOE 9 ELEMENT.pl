% A board is a list of 9 elements. x, o, or ' '.
% Main entry point: finds the computer's (x) best move.
best_move(Board, Move) :-
 findall(Score-M, (move(x, Board, M, NewBoard), minimax(NewBoard, o,
Score)), Pairs),
 keysort(Pairs, SortedPairs),
 reverse(SortedPairs, [_-Move|_]).
% A player makes a move.
move(Player, Board, Pos, NewBoard) :-
 nth1(Pos, Board, ' '),
 replace(Pos, Board, Player, NewBoard).
% Minimax for the minimizing player (o).
minimax(Board, o, Score) :-
 win(Board, x), Score is 1, !.
minimax(Board, o, Score) :-
 win(Board, o), Score is -1, !.minimax(Board, o, Score) :-
 draw(Board), Score is 0, !.
minimax(Board, o, Score) :-
 findall(S, (move(o, Board, _, NewBoard), maxi(NewBoard, x, S)), Scores),
 min_list(Scores, Score).
% Minimax for the maximizing player (x).
maxi(Board, x, Score) :-
 win(Board, x), Score is 1, !.
maxi(Board, x, Score) :-
 win(Board, o), Score is -1, !.
maxi(Board, x, Score) :-
 draw(Board), Score is 0, !.
maxi(Board, x, Score) :-
 findall(S, (move(x, Board, _, NewBoard), minimax(NewBoard, o, S)), Scores),
 max_list(Scores, Score).
% Win conditions.
win(B, P) :- row_win(B, P).
win(B, P) :- col_win(B, P).
win(B, P) :- diag_win(B, P).
row_win([P, P, P, _, _, _, _, _, _], P).
row_win([_, _, _, P, P, P, _, _, _], P).
row_win([_, _, _, _, _, _, P, P, P], P).
col_win([P, _, _, P, _, _, P, _, _], P).
col_win([_, P, _, _, P, _, _, P, _], P).
col_win([_, _, P, _, _, P, _, _, P], P).
diag_win([P, _, _, _, P, _, _, _, P], P).
diag_win([_, _, P, _, P, _, P, _, _], P).
% Check for a draw.
draw(Board) :-
 \+ win(Board, x),
 \+ win(Board, o),
 \+ member(' ', Board).
% Helper predicate to replace an element in a list.
replace(I, L, E, K) :-
 nth1(I, L, _, R),
 nth1(I, K, E, R).
% Helper predicate to print the board.
print_board([A,B,C,D,E,F,G,H,I]) :-
 format('~n ~w | ~w | ~w ~n', [A,B,C]),
 format('-----------~n'),
 format(' ~w | ~w | ~w ~n', [D,E,F]),
 format('-----------~n'),
 format(' ~w | ~w | ~w ~n', [G,H,I]), nl.
