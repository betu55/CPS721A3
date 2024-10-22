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

%%%%% SECTION: minAndMaxList
%%%%% Below, you should define rules for the predicate "minList(List, M)", 
%%%%% which takes in an input List and finds the minimal element there.
%%%%%
%%%%% You should also define rules for the predicate "maxList(List, M)", 
%%%%% which takes in an input List and finds the maximal element there.
%%%%%
%%%%% If you introduce any other helper predicates for implementing minList
%%%%% and maxList, they should be included in this section.
minList([],[]).
minList([M], M).
minList([H|T], M):- minList(T, M1), not(M1 = []), M1 > H, M = H.
minList([H|T], M):- minList(T, M1), not(M1 = []), M1 =< H, M = M1.

maxList([],[]).
maxList([M], M).
maxList([H|T], M):- maxList(T, M1), not(M1 = []), M1 > H, M = M1.
maxList([H|T], M):- maxList(T, M1), not(M1 = []), M1 =< H, M = H.

%%%%% SECTION: fertilizersSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than minList, maxList, and their helpers) that you choose to introduce.


% Define valid domains
plant_numbers([1, 2, 3, 4, 5]).
fertilizers([bone_meal, compost, egg_shells, manure, seaweed]).
heights([1, 2, 4, 5, 7]).
tomato_counts([4, 6, 9, 12, 21]).
weights([3, 9, 10, 14, 19]).

isMember(Element, [Element|Tail]).
isMember(Element, [Head|Tail]) :- isMember(Element, Tail).

% plant data structure
% Define the plant data structure
plant(PlantNumber, Fertilizer, Height, TomatoCount, Weight).
    
solve(List) :-
    List = [
        plant(1, Fertilizer1, Height1, TomatoCount1, Weight1),
        plant(2, Fertilizer2, Height2, TomatoCount2, Weight2),
        plant(3, Fertilizer3, Height3, TomatoCount3, Weight3),
        plant(4, Fertilizer4, Height4, TomatoCount4, Weight4),
        plant(5, Fertilizer5, Height5, TomatoCount5, Weight5)
    ],

    % storing the lists in variables.
    fertilizers(Fertilizers),
    heights(Heights),
    tomato_counts(TomatoCounts),
    weights(Weights),

    % assuring that the values for each plant are within our domain.
    % Fertilizers
    isMember(Fertilizer1, Fertilizers),
    isMember(Fertilizer2, Fertilizers),
    isMember(Fertilizer3, Fertilizers),
    isMember(Fertilizer4, Fertilizers),
    isMember(Fertilizer5, Fertilizers),
    % Heights
    isMember(Height1, Heights),
    isMember(Height2, Heights),
    isMember(Height3, Heights),
    isMember(Height4, Heights),
    isMember(Height5, Heights),
    % TomatoCounts
    isMember(TomatoCount1, TomatoCounts),
    isMember(TomatoCount2, TomatoCounts),
    isMember(TomatoCount3, TomatoCounts),
    isMember(TomatoCount4, TomatoCounts),
    isMember(TomatoCount5, TomatoCounts),
    % Weights
    isMember(Weight1, Weights),
    isMember(Weight2, Weights),
    isMember(Weight3, Weights),
    isMember(Weight4, Weights),
    isMember(Weight5, Weights),
    
    % Constraints
    % Constraint #1: The 3rd plant was not fertilized with manure, 
    not(Fertilizer3 = manure),
    % and it produced a heavier weight than plant two,
    Weight3 > Weight2,
    % Plant3 had a lighter weight than the manure-fertilized plant.
    member(plant(N, manure, H, TC, MPWeight), List), % Call the helper to get the manure weight
    Weight2 < MPWeight,
    
    % Constraint #2: The 4th plant grew taller than plant three, but plant two grew taller than plant four.
    Height4 > Height3,
    Height2 > Height4,

    % Constraint #7. Plant one was taller than plant three by one foot, but it only grew half as tall as plant five.
    Height1 is (Height3 + 1),
    Height1 is (Height5 / 2),

    % Constraint #3: Plants three, four and five were not fertilized with either seaweed or bone-meal.
    not(Fertilizer3 = seaweed), not(Fertilizer3 = bone_meal),
    not(Fertilizer4 = seaweed), not(Fertilizer4 = bone_meal),
    not(Fertilizer5 = seaweed), not(Fertilizer5 = bone_meal),

    % Constraint #4: The tallest and shortest plants did not produce either the most tomatoes or the heaviest weight.
    maxList(Heights, Tallest), minList(Heights, Shortest), maxList(TomatoCounts, MaxTomatoes) , maxList(Weights, MaxWeight),
    % getting the tallest and shortest plants information. (FT = FertilizerTallest, NT = NumberTallest, etc.)
    isMember(plant(NT, FT, Tallest, TomatoCountTallest, TallestWeight), List), NT < 6,
    isMember(plant(NS, FS, Shortest, TomatoCountShortest, ShortestWeight), List), NS < 6,
    % making sure that the tallest and shortest plants did not produce the most tomatoes or the heaviest weight.
    not(TomatoCountTallest = MaxTomatoes), 
    not(WeightTallest = MaxWeight),      
    not(TomatoCountShortest = MaxTomatoes),
    not(WeightShortest = MaxWeight),

    % Constraint #8: Plant five did not produced the heaviest weight.
    Weight5 < MaxWeight,

    % Constraint #5: The plant fertilized with egg-shells produced half as many tomatoes as plant one, but it did produce the heaviest weight. 
    isMember(plant(NPlantEggShells, egg_shells, HeightEggShells, TomatoCountEggShells, WeightEggShells), List), NPlantEggShells < 6,
    TomatoCount1 is (TomatoCountEggShells * 2),
    maxList(Weights, WeightEggShells),

    % Constraint #6: Seaweed fertilized the tallest plant, but that plant produced the fewest tomatoes, 
    isMember(plant(NTallest, seaweed, HT, TomatoCountTallest, TallestWeight), List), NTallest < 6,
    HT = Tallest,
    minList(TomatoCounts, TomatoCountTallest),
    % and bone-meal fertilized the plant that produced the lightest weight (HL = HeightLightest).
    isMember(plant(NLightest, bone_meal, HL, TomatoCountsightest, LightestWeight), List), NLightest < 6,
    minList(Weights, LightestWeight).


solve_and_print :-
    solve(List),
    write('Plant 1: '), write(List), nl,
    write('Plant 2: '), write(List), nl,
    write('Plant 3: '), write(List), nl,
    write('Plant 4: '), write(List), nl,
    write('Plant 5: '), write(List), nl.




