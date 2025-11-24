edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).
edge(d, h).
edge(d, i).
edge(e, j).
edge(e, k).
edge(f, l).
edge(f, m).
edge(g, n).

bfs(Start, Goal, Path) :-
    bfs_search([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

bfs_search([[Goal|RestPath] | _], Goal, [Goal|RestPath]).

bfs_search([[Node|RestPath] | OtherPaths], Goal, Path) :-
    findall([Next,Node|RestPath],
            (edge(Node, Next), \+ member(Next, [Node|RestPath])),
            NewPaths),
    append(OtherPaths, NewPaths, UpdateQueue),
    bfs_search(UpdateQueue, Goal, Path).

