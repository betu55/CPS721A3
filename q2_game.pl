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
countOccurrences(X, [H|T], Count) :- not(X = H), countOccurrences(X, T, Count).
countOccurrences(X, [X|T], Count) :- Count < 4, NewCount is Count + 1, countOccurrences(X, T, NewCount).
countOccurrences(X, [], Count) :- not(Count = 4), fail.

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
outcome(w). 
outcome(l). 
outcome(d). 
outcome(n).
% chech if an element occurs ecactly once in a list
oneExactly(X, List) :- countOccurrences1(X, List, 0).
countOccurrences1(X, [], 1).
countOccurrences1(X, [H|T], Count) :- not(X = H), countOccurrences1(X, T, Count).
countOccurrences1(X, [X|T], Count) :- Count < 1, NewCount is Count + 1, countOccurrences1(X, T, NewCount).
countOccurrences1(X, [], Count) :- not(Count = 1), fail.
% check if an element occurs exactly 2 times in a list
twoExactly(X, List) :- countOccurrences2(X, List, 0).
countOccurrences2(X, [], 2).
countOccurrences2(X, [H|T], Count) :- not(X = H), countOccurrences2(X, T, Count).
countOccurrences2(X, [X|T], Count) :- Count < 2, NewCount is Count + 1, countOccurrences2(X, T, NewCount).
countOccurrences2(X, [], Count) :- not(Count = 2), fail.

% checks element membership in a list.
isMember(Element, [Element|Tail]).
isMember(Element, [Head|Tail]) :- isMember(Element, Tail).

% IMPLEMENTATION OF THE SOLVE PREDICATE
% since there are 5 teams and 5 rounds, there will be 25 individual outcomes in total.
% we will define the outcomes of each match in the solve predicate according to our constraints.

solve([
    Oakville_R1, Pickering_R1, RichmondHill_R1, Scarborough_R1, Toronto_R1,
    Oakville_R2, Pickering_R2, RichmondHill_R2, Scarborough_R2, Toronto_R2,
    Oakville_R3, Pickering_R3, RichmondHill_R3, Scarborough_R3, Toronto_R3,
    Oakville_R4, Pickering_R4, RichmondHill_R4, Scarborough_R4, Toronto_R4,
    Oakville_R5, Pickering_R5, RichmondHill_R5, Scarborough_R5, Toronto_R5
]) :- 
    format('Starting to solve~n'),
    % 1
    % Pickering lost to scarborough in round 1 and won against Oakville in round 2
    % this gives us 4 outcomes
    outcome(Pickering_R1), Pickering_R1 = l, outcome(Scarborough_R1), Scarborough_R1 = w, 
    outcome(Oakville_R2), Oakville_R2 = l, outcome(Pickering_R2), Pickering_R2 = w,
    format('Step 1 passed~n'),
    % 2
    % Toronto did not play in the third round; they had one win and one loss in the previous two rounds.
    % there are 3 outcomes here
    outcome(Toronto_R3), Toronto_R3 = n, 
    outcome(Toronto_R1), outcome(Toronto_R2), 
    oneExactly(w, [Toronto_R1, Toronto_R2]),
    oneExactly(l, [Toronto_R1, Toronto_R2]),   
    format('Step 2 passed~n'),
    % 3
    % Oakville did not participate in the fourth round, but they already won twice in the preceding three matches.
    outcome(Oakville_R4), Oakville_R4 = n,
    outcome(Oakville_R1), outcome(Oakville_R2), outcome(Oakville_R3),
    twoExactly(w, [Oakville_R1, Oakville_R2, Oakville_R3]),
    format('Step 3 passed~n'),
    % 6
    % None of the matches in the first, in the second and in the third rounds finished with a draw.
    % we first need to generate outcomes for scarboroughs second and third rounds, and pickerings third round since those are the ones we don't have informations for.
    outcome(Scarborough_R2), outcome(Scarborough_R3), outcome(Pickering_R3),
    % since there is no draw during the first 3 rounds:
    not(isMember(d, [Scarborough_R1, Pickering_R1, RichmondHill_R1, Toronto_R1, Oakville_R1])),
    not(isMember(d, [Scarborough_R2, Pickering_R2, RichmondHill_R2, Toronto_R2, Oakville_R2])),
    not(isMember(d, [Scarborough_R3, Pickering_R3, RichmondHill_R3, Toronto_R3, Oakville_R3])), 
    format('Step 6 passed~n'),
    % 5
    % here we go with constraint number 5 because it makes sense for this information to be processed before
    % constraint 4
    % Before the fourth round, Richmond Hill won only once and lost once.
    outcome(RichmondHill_R3), outcome(RichmondHill_R2), outcome(RichmondHill_R1),
    oneExactly(w, [RichmondHill_R1, RichmondHill_R2, RichmondHill_R3]),
    oneExactly(l, [RichmondHill_R1, RichmondHill_R2, RichmondHill_R3]),
    format('Step 5 passed~n'),
    % now we generate some constraints that are apparent from the previous constraints.
    % we know that there is exactly 2 losses, 2 wins and 1 no play, for round 1.
    % the same is true for rounds 2 and 3.
    twoExactly(l, [RichmondHill_R1, Scarborough_R1, Toronto_R1, Pickering_R1, Oakville_R1]),
    twoExactly(w, [RichmondHill_R1, Scarborough_R1, Toronto_R1, Pickering_R1, Oakville_R1]),
    oneExactly(n, [RichmondHill_R1, Scarborough_R1, Toronto_R1, Pickering_R1, Oakville_R1]),
    % round 2
    twoExactly(l, [RichmondHill_R2, Scarborough_R2, Toronto_R2, Pickering_R2, Oakville_R2]),
    twoExactly(w, [RichmondHill_R2, Scarborough_R2, Toronto_R2, Pickering_R2, Oakville_R2]),
    oneExactly(n, [RichmondHill_R2, Scarborough_R2, Toronto_R2, Pickering_R2, Oakville_R2]),
    % round 3
    twoExactly(l, [RichmondHill_R3, Scarborough_R3, Toronto_R3, Pickering_R3, Oakville_R3]),
    twoExactly(w, [RichmondHill_R3, Scarborough_R3, Toronto_R3, Pickering_R3, Oakville_R3]),
    oneExactly(n, [RichmondHill_R3, Scarborough_R3, Toronto_R3, Pickering_R3, Oakville_R3]),
    format('constraints 1-3 passed~n'),
    % 4
    % finally we hace constraint 4 which is the last one.
    % All matches in the fourth and in the fifth round finished with a draw.
    % 4
    % All matches in the fourth and in the fifth round finished with a draw.
    % since Oakville did not participate in the fourth round, we will generate the outcomes for the other 4 teams.
    outcome(RichmondHill_R4), outcome(Scarborough_R4), outcome(Toronto_R4), outcome(Pickering_R4), 
    fourExactly(d, [RichmondHill_R4, Scarborough_R4, Toronto_R4, Pickering_R4, Oakville_R4]),
    % round 5 is the same as round 4, but we dont know which team isnt playing.
    outcome(RichmondHill_R5), outcome(Scarborough_R5), outcome(Toronto_R5), outcome(Pickering_R5), outcome(Oakville_R5),
    oneExactly(n, [RichmondHill_R5, Scarborough_R5, Toronto_R5, Pickering_R5, Oakville_R5]),
    fourExactly(d, [RichmondHill_R5, Scarborough_R5, Toronto_R5, Pickering_R5, Oakville_R5]).
    format('Step 4 passed~n').


solve_and_print :-
    solve([
        Toronto_R1, Pickering_R1, RichmondHill_R1, Scarborough_R1, Oakville_R1,
        Toronto_R2, Pickering_R2, RichmondHill_R2, Scarborough_R2, Oakville_R2,
        Toronto_R3, Pickering_R3, RichmondHill_R3, Scarborough_R3, Oakville_R3,
        Toronto_R4, Pickering_R4, RichmondHill_R4, Scarborough_R4, Oakville_R4,
        Toronto_R5, Pickering_R5, RichmondHill_R5, Scarborough_R5, Oakville_R5
    ]),
    write('Fixture Results:'), nl,
    write('Round 1:'), nl, write('Toronto: '), write(Toronto_R1), nl, write('Pickering: '), write(Pickering_R1), nl, write('Richmond Hill: '), write(RichmondHill_R1), nl, write('Scarborough: '), write(Scarborough_R1), nl, write('Oakville: '), write(Oakville_R1), nl,
    write('Round 2:'), nl, write('Toronto: '), write(Toronto_R2), nl, write('Pickering: '), write(Pickering_R2), nl, write('Richmond Hill: '), write(RichmondHill_R2), nl, write('Scarborough: '), write(Scarborough_R2), nl, write('Oakville: '), write(Oakville_R2), nl,
    write('Round 3:'), nl, write('Toronto: '), write(Toronto_R3), nl, write('Pickering: '), write(Pickering_R3), nl, write('Richmond Hill: '), write(RichmondHill_R3), nl, write('Scarborough: '), write(Scarborough_R3), nl, write('Oakville: '), write(Oakville_R3), nl,
    write('Round 4:'), nl, write('Toronto: '), write(Toronto_R4), nl, write('Pickering: '), write(Pickering_R4), nl, write('Richmond Hill: '), write(RichmondHill_R4), nl, write('Scarborough: '), write(Scarborough_R4), nl, write('Oakville: '), write(Oakville_R4), nl,
    write('Round 5:'), nl, write('Toronto: '), write(Toronto_R5), nl, write('Pickering: '), write(Pickering_R5), nl, write('Richmond Hill: '), write(RichmondHill_R5), nl, write('Scarborough: '), write(Scarborough_R5), nl, write('Oakville: '), write(Oakville_R5), nl.