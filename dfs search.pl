solve(Node,Solution):-
    depthfirst([], Node,RevSolution),
    reverse(Revsolution,Solution).
deptfirst(Path,Node,[Node|Path]):-
    goal(Node).
depthfirst(Path, Node, Solution):-
    edge(Node, Next),
    not(member(Next, Path)),
    depthfirst([Node|Path], Next, Solution).
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).
goal(g).
