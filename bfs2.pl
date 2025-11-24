% Greedy Best-First Search for 8-puzzle
% state representation: list of 9 numbers, 0=blank.
% example goal: [1,2,3,4,5,6,7,8,0]

% Public entry point
solve_best_first(Start, Goal, Path):-
    h_misplaced(Start, Goal, H0),
    best_first([H0-(Start-[Start])], Goal, [], Path).

% Main loop
best_first([], _, _, _) :-
    fail.  % If no states are left to explore, fail.
best_first([_H-(State-PathRev)|_], Goal, _, Path):-
    State = Goal,   % If the current state is the goal
    reverse(PathRev, Path), !.  % Reverse the path and return the solution.

best_first([_H-(State-PathRev)|RestOpen], Goal, Closed, Path):-
    findall(Hn-(Next-NewPathRev),
            (   move(State, Next),
                \+ member(Next, PathRev),
                \+ member(Next, Closed),
                h_misplaced(Next, Goal, Hn),
                NewPathRev = [Next|PathRev]
            ),
            Children),
    append(RestOpen, Children, Open2),
    keysort(Open2, SortedOpen),   % Sort the open list by heuristic value
    best_first(SortedOpen, Goal, [State|Closed], Path).

% Generate a valid next state by moving the blank (0)
move(State, NextState):-
    nth1(BlankPos, State, 0),  % Find the position of the blank (0)
    adj(BlankPos, SwapPos),     % Find adjacent positions for the blank
    swap(State, BlankPos, SwapPos, NextState).  % Swap the blank with the adjacent position

% Adjacency in 3x3 grid (symmetric)
adj(1,2). adj(1,4).
adj(2,1). adj(2,3). adj(2,5).
adj(3,2). adj(3,6).
adj(4,1). adj(4,5). adj(4,7).
adj(5,2). adj(5,4). adj(5,6). adj(5,8).
adj(6,3). adj(6,5). adj(6,9).
adj(7,4). adj(7,8).
adj(8,5). adj(8,7). adj(8,9).
adj(9,6). adj(9,8).

% Swap the elements at positions I and J in the list
swap(State, I, J, NewState) :-
    nth1(I, State, EI),  % Get the element at position I
    nth1(J, State, EJ),  % Get the element at position J
    replace(State, I, EJ, Temp),  % Replace I with EJ
    replace(Temp, J, EI, NewState).  % Replace J with EI

% Replace the element at position I in the list with X
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1, I1 is I - 1,
    replace(T, I1, X, R).

% Heuristic: number of misplaced tiles (excluding the blank tile)
h_misplaced(State, Goal, H) :-
    h_misplaced_acc(State, Goal, 0, H).

% Accumulator version of h_misplaced/3
h_misplaced_acc([], [], Acc, Acc).
h_misplaced_acc([0|Ts], [_|Gs], Acc, H) :-
    !, h_misplaced_acc(Ts, Gs, Acc, H).  % Ignore blank tile.
h_misplaced_acc([X|Ts], [Y|Gs], Acc, H) :-
    X == Y, !, h_misplaced_acc(Ts, Gs, Acc, H).  % If tiles match, no increment.
h_misplaced_acc([_|Ts], [_|Gs], Acc, H) :-
    Acc1 is Acc + 1,
    h_misplaced_acc(Ts, Gs, Acc1, H).  % Increment counter for misplaced tiles.
