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

%%%%% SECTION: fourExactly
%%%%% Below, you should define rules for the predicate "fourExactly(X,List)", 
%%%%% which takes in an input List and checks whether there are exactly 4 
%%%%% occurrences of a given element X in the list.
%%%%%
%%%%% If you introduce any other helper predicates for implementing fourExactly,
%%%%% they should be included in this section.

fourExactly(X, List) :- countOccurrences(X, List, 0).

countOccurrences(X, [], 4).
countOccurrences(X, [H|T], Count) :- X \= H, countOccurrences(X, T, Count).
countOccurrences(X, [X|T], Count) :- Count < 4, NewCount is Count + 1, countOccurrences(X, T, NewCount).
countOccurrences(X, [], Count) :- Count \= 4, fail.

%%%%% SECTION: gameSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than fourExactly and its helpers) that you choose to introduce.

% Define the domain
domain([n, l, d, w]).

% Define the variables for each match outcome
solve([R1, R2, R3, R4, R5]) :-
    R1 = [P_S, _, _, _, _],
    R2 = [P_O, _, _, _, _],
    R3 = [_, _, _, _, _],
    R4 = [d, d, d, d, d],
    R5 = [d, d, d, d, d],

    P_S = l,
    P_O = w.


% Define the solve_and_print predicate
solve_and_print :-
    solve([R1, R2, R3, R4, R5]),
    format('Round 1: ~w~n', [R1]),
    format('Round 2: ~w~n', [R2]),
    format('Round 3: ~w~n', [R3]),
    format('Round 4: ~w~n', [R4]),
    format('Round 5: ~w~n', [R5]).


% solve_and_print :-