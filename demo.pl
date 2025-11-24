solve(Node,Solution):-
    depthfirst([], Node,Revsolution),
    reverse(Revsolution,Solution).

depthfirst(Path,Node,[Node|Path]):-
   goal(Node).
depthfirst(Path,Node,Solution):-
    edge(Node,Next),
    not(member(Next,Path)),
    depthfirst([Node|Path],Next,Solution).
edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(c,f).
edge(c,g).
goal(g).


