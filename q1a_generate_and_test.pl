% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Subha Tasnim
%%%%% NAME: Bemenet Bekele
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: puzzleGenerateAndTest
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce

dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9).
al_diff([ ]).
al_diff([N | L]) :- not my_mem(N,L), al_diff(L).
my_mem(X,[X | L]).
my_mem(X,[M | L]) :- my_mem(X,L).

solve_and_print :-
    solve([J,E,T,A,X,L,O,V]),
    write("   "), write(J), write(E), write(T), nl,
    write("  * "), write(A), write(X), nl,
    write("------"),nl,
    write("+ "),write(A),write(X),write(L),write(E),nl,
    write("  "), write(J), write(E), write(T), write(.), nl,
    write("------"),nl,
    write("  "), write(L), write(O), write(V), write(E), nl.

solve([J,E,T,A,X,L,O,V]):-
    dig(J), dig(E), dig(T), dig(A), dig(X), dig(L), dig(O), dig(V),
    J > 0, A > 0, L > 0,
    V is (L+T) mod 10, C1 is (L+T) // 10,
    O is (X+E+C1) mod 10, C2 is (X+E+C1) // 10,
    L is (A+J+C2),
    E is (T*X) mod 10, C3 is (T*X) // 10,
    L is (E*X+C3) mod 10, C4 is (E*A+C3) // 10,
    X is (J*X+C4) mod 10, A is (J*X+C4) // 10,
    T is (T*A),
    al_diff([J,E,T,A,X,L,O,V]).
