% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: 
%%%%% NAME:
%%%%% NAME:
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: puzzleInterleaving
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce

car(0). car(1).
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
    dig(J), J > 0,
    dig(T),
    car(A), A > 0, car(C1),
    dig(X), X is (J*X+C1) mod 10,
    dig(E), E is (T*X) mod 10, C2 is (T*X) // 10, car(C3),
    dig(L), L > 0, L is (E*X+C2) mod 10, L is (A+J+C3), C4 is (L+T) // 10,
    dig(O), O is (X+E+C4) mod 10,
    V is (L+T) mod 10,
    al_diff([J,E,T,A,X,L,O,V]).
