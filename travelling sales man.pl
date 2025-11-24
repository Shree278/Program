distance(a, b, 10).
distance(a, c, 15).
distance(a, d, 20).
distance(b, c, 35).
distance(b, d, 25).
distance(c, d, 30).

dist(X, Y, D) :- distance(X, Y, D).
dist(X, Y, D) :- distance(Y, X, D).

tsp(Start, Path, Cost) :-
    findall(C, (distance(Start, C, _)), Cities1),
    sort(Cities1, Cities),
    permutation(Cities, Perm),
    append([Start|Perm], [Start], Path),
    path_cost(Path, Cost).

path_cost([_], 0).
path_cost([A,B|T], Cost) :-
    dist(A, B, D),
    path_cost([B|T], Rest),
    Cost is D + Rest.

tsp_best(Start, BestPath, MinCost) :-
    setof((C, P), tsp(Start, P, C), [(MinCost, BestPath)|_]).
