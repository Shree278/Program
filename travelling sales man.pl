% ----- Facts -----
%  distance(City1, City2, Distance).
distance(a, b, 10).
distance(a, c, 15).
distance(a, d, 20).
distance(b, c, 35).
distance(b, d, 25).
distance(c, d, 30).

% distance is symmetric
dist(X, Y, D) :- distance(X, Y, D).
dist(X, Y, D) :- distance(Y, X, D).

% ----- Generate tour -----
% find all permutations of circles (except start), calculate cost
tsp(Start, Path, Cost) :-
    findall(C, (distance(Start, C, _)), Cities1),
    sort(Cities1, Cities),                % get unique cities
    permutation(Cities, Perm),
    append([Start|Perm], [Start], Path),  % full cycle
    path_cost(Path, Cost).

% ----- Calculate path cost -----
path_cost([_], 0).
path_cost([A,B|T], Cost) :-
    dist(A, B, D),
    path_cost([B|T], Rest),
    Cost is D + Rest.

% ----- Find best path -----
tsp_best(Start, BestPath, MinCost) :-
    setof((C, P), tsp(Start, P, C),  [(MinCost, BestPath)|_]).
