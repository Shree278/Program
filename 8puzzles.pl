solve_best_first(Start, Goal, Path) :-
    h_misplaced(Start, Goal, H0),
    best_first([H0-(Start-[Start])], Goal, [], Path).

best_first([], _, _, _) :-
    fail.

best_first([_H-(State-PathRev) |_], Goal, _, Path) :-
    State =:= Goal,
    reverse(PathRev, Path).

best_first([_H-(State-PathRev) | RestOpen], Goal, Closed, Path) :-
    findall(
        Hn-(Next-NewPathRev),
        ( move(State, Next),
          \+ member(Next, PathRev),
          \+ member(Next, Closed),
          h_misplaced(Next, Goal, Hn),
          NewPathRev = [Next | PathRev]
        ),
        Children
    ),
    append(RestOpen, Children, Open2),
    keysort(Open2, SortedOpen),
    best_first(SortedOpen, Goal, [State|Closed], Path).

move(State, NextState) :-
    nth1(BlankPos, State, 0),
    adj(BlankPos, SwapPos),
    swap(State, BlankPos, SwapPos, NextState).

adj(1,2). adj(1,4).
adj(2,1). adj(2,3). adj(2,5).
adj(3,2). adj(3,6).
adj(4,1). adj(4,5). adj(4,7).
adj(5,2). adj(5,4). adj(5,6). adj(5,8).
adj(6,3). adj(6,5). adj(6,9).
adj(7,4). adj(7,8).
adj(8,5). adj(8,7). adj(8,9).
adj(9,6). adj(9,8).

swap(State, I, J, NewState) :-
    nth1(I, State, EI),
    nth1(J, State, EJ),
    replace(State, I, EJ, Temp),
    replace(Temp, J, EI, NewState).

replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).

h_misplaced(State, Goal, H) :-
    h_misplaced_acc(State, Goal, 0, H).

h_misplaced_acc([], [], Acc, Acc).
h_misplaced_acc([0|Ts], [_|Gs], Acc, H) :-
    h_misplaced_acc(Ts, Gs, Acc, H).
h_misplaced_acc([X|Ts], [Y|Gs], Acc, H) :-
    X =:= Y,
    h_misplaced_acc(Ts, Gs, Acc, H).
h_misplaced_acc([_|Ts], [_|Gs], Acc, H) :-
    Acc1 is Acc + 1,
    h_misplaced_acc(Ts, Gs, Acc1, H).
