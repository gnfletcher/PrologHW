%Prolog Homework
%Authors: Greg Fletcher,
%medical_test(+PatientData, -ProbDPos1, -ProbDPos2, -ProbHNeg1, -ProbHNeg2, -Best).
%Takes in patient data and calculates prbability based on test results.

medical_test(PatientData, ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Best) :- 
	sumstat(PatientData, SickPos1, SickPos2, HealthNeg1, HealthNeg2, Pos1, Pos2, Neg1, Neg2),
	ProbDPos1 = SickPos1/Pos1,
	ProbDPos2 = SickPos2/Pos2,
	ProbHNeg1 = HealthNeg1/Neg1,
	ProbHNeg2 = HealthNeg2/Neg2,
	compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion),
    Best = Desicion,
    write(ProbDPos1).

sumstat([], 0, 0, 0, 0, 0, 0, 0, 0).

sumstat([H|T], SickPos1, SickPos2, HealthNeg1, HealthNeg2, Pos1, Pos2, Neg1, Neg2):-
	sumstat(T, TSickPos1, TSickPos2, THealthNeg1, THealthNeg2, TPos1, TPos2, TNeg1, TNeg2),
	testresults(H, RSickPos1, RSickPos2, RHealthNeg1, RHealthNeg2, RPos1, RPos2, RNeg1, RNeg2),
	SickPos1 is RSickPos1 + TSickPos1,
    SickPos2 is RSickPos2 + TSickPos2,
	HealthNeg1 is RHealthNeg1 + THealthNeg1,
    HealthNeg2 is RHealthNeg2 + THealthNeg2,
	Pos1 is RPos1 + TPos1,
	Pos2 is RPos2 + TPos2,
	Neg1 is RNeg1 + TNeg1,
	Neg2 is RNeg2 + TNeg2.

testresults([_, 0, X, Y], SickPos1, SickPos2, HealthNeg1, HealthNeg2, Pos1, Pos2, Neg1, Neg2) :- 
	X == 0, Y == 0, SickPos1 is 0, SickPos2 is 0, HealthNeg1 is 1, HealthNeg2 is 1, Pos1 is 0, Pos2 is 0, Neg1 is 1, Neg2 is 1;
	X == 0, Y == 1, SickPos1 is 0, SickPos2 is 0, HealthNeg1 is 0, HealthNeg2 is 1, Pos1 is 0, Pos2 is 1, Neg1 is 1, Neg2 is 0;
	X == 1, Y == 0, SickPos1 is 0, SickPos2 is 0, HealthNeg1 is 1, HealthNeg2 is 0, Pos1 is 1, Pos2 is 0, Neg1 is 0, Neg2 is 1;
	X == 1, Y == 1, SickPos1 is 0, SickPos2 is 0, HealthNeg1 is 0, HealthNeg2 is 0, Pos1 is 1, Pos2 is 1, Neg1 is 0, Neg2 is 0.

testresults([_, 1, X, Y], SickPos1, SickPos2, HealthNeg1, HealthNeg2, Pos1, Pos2, Neg1, Neg2) :- 
	X == 0, Y == 0, SickPos1 is 0, SickPos2 is 0, HealthNeg1 is 0, HealthNeg2 is 0, Pos1 is 0, Pos2 is 0, Neg1 is 1, Neg2 is 1;
	X == 0, Y == 1, SickPos1 is 0, SickPos2 is 1, HealthNeg1 is 0, HealthNeg2 is 0, Pos1 is 0, Pos2 is 1, Neg1 is 1, Neg2 is 0;
	X == 1, Y == 0, SickPos1 is 1, SickPos2 is 0, HealthNeg1 is 0, HealthNeg2 is 0, Pos1 is 1, Pos2 is 0, Neg1 is 0, Neg2 is 1;
	X == 1, Y == 1, SickPos1 is 1, SickPos2 is 1, HealthNeg1 is 0, HealthNeg2 is 0, Pos1 is 1, Pos2 is 1, Neg1 is 0, Neg2 is 0.

compare(ProbDPos1, ProbDPos2, ProbHNeg1, ProbHNeg2, Desicion) :- 
	ProbDPos1 > ProbDPos2, 
	ProbHNeg1 > ProbHNeg2,
	Desicion = 'test1';
	ProbDPos1 < ProbDPos2, 
	ProbHNeg1 < ProbHNeg2,
	Desicion = 'test2';
    ProbDPos1 =< ProbDPos2, 
	ProbHNeg1 >= ProbHNeg2,
    Desicion = 'neither';
    ProbDPos1 >= ProbDPos2, 
	ProbHNeg1 < ProbHNeg2,
    Desicion = 'neither'.
