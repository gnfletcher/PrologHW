%Prolog Homework
%Authors: Greg Fletcher,
%medical_test(+PatientData, -ProbDPos1, -ProbDPos2, -ProbHNeg1, -ProbHNeg2, -Best).
%Takes in patient data and calculates prbability based on test results.

medical_test(PatientData, ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :- 
	sumstat(PatientData, Sick, Health, Pos1, Pos2, Neg1, Neg2),
	ProbDPos1 is Sick/Pos1,
	ProbDPos2 is Sick/Pos2,
	ProbHNeg1 is Health/Neg1,
	ProbHNeg2 is Health/Neg2,
	compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion),
	Best is Desicion.

sumstat([], 0, 0, 0, 0, 0, 0).

sumstat([H|T], Sick, Health, Pos1, Pos2, Neg1, Neg2):-
	sumstat(T, TSick, THealth, TPos1, TPos2, TNeg1, TNeg2),
	testresults(H, RSick, RHealth, RPos1, RPos2, RNeg1, RNeg2),
	Sick is RSick + TSick,
	Health is RHealth + THealth,
	Pos1 is RPos1 + TPos1,
	Pos2 is RPos2 + TPos2,
	Neg1 is RNeg1 + TNeg1,
	Neg2 is RNeg2 + TNeg2.

testresults([_, 0, X, Y], Sick, Health, Pos1, Pos2, Neg1, Neg2) :- 
	X == 0, Y == 0, Sick is 0, Health is 1, Pos1 is 0, Pos2 is 0, Neg1 is 1, Neg2 is 1;
	X == 0, Y == 1, Sick is 0, Health is 1, Pos1 is 0, Pos2 is 1, Neg1 is 1, Neg2 is 0;
	X == 1, Y == 0, Sick is 0, Health is 1, Pos1 is 1, Pos2 is 0, Neg1 is 0, Neg2 is 1;
	X == 1, Y == 1, Sick is 0, Health is 1, Pos1 is 1, Pos2 is 1, Neg1 is 0, Neg2 is 0.

testresults([_, 1, X, Y], Sick, Health, Pos1, Pos2, Neg1, Neg2) :- 
	X == 0, Y == 0, Sick is 1, Health is 0, Pos1 is 0, Pos2 is 0, Neg1 is 1, Neg2 is 1;
	X == 0, Y == 1, Sick is 1, Health is 0, Pos1 is 0, Pos2 is 1, Neg1 is 1, Neg2 is 0;
	X == 1, Y == 0, Sick is 1, Health is 0, Pos1 is 1, Pos2 is 0, Neg1 is 0, Neg2 is 1;
	X == 1, Y == 1, Sick is 1, Health is 0, Pos1 is 1, Pos2 is 1, Neg1 is 0, Neg2 is 0.

compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion) :- 
	ProbDPos1 > ProbDPos2, 
	ProbHNeg1 > ProbHNeg2,
	Desicion is "test1".
	
compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion) :- 
	ProbDPos1 < ProbDPos2, 
	ProbHNeg1 < ProbHNeg2,
	Desicion is "test2".
	
compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion) :- 
	ProbDPos1 >= ProbDPos2, 
	ProbHNeg1 =< ProbHNeg2;
	ProbDPos1 =< ProbDPos2, 
	ProbHNeg1 >= ProbHNeg2,
	Desicion is "neither".