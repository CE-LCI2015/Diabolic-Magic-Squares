/*** PRED ***/


/*Generates a SANC matrix
* Type is (S; A; N; C)
*/
generateMatrix(Type, Matrix) :- generateMatrix(4, 4, Type, [], Matrix).

/*Stops the process*/
generateMatrix(_, 0, _, Matrix, Matrix).

/*Generates a line*/
generateMatrix(Cols, Rows, Type, Res, Matrix) :- Rows > 0, NewRows is Rows - 1, generateList(Cols, Rows, Type, NewRow), generateMatrix(Cols, NewRows, Type, [NewRow|Res], Matrix).


/*** PRED ***/


/*Generates a list with ones and zeros depending on the type
* Type is (S; A; N; C)
* Rows and Cols goes from list[4] to list[1], so there is no list[0]
*/
generateList(Cols, Rows, Type, List) :- generateList(Cols, Rows, Type, [], List).

/*Stops the process*/
generateList(0, _, _, List, List).

/*Fills the line with a one or a zero, based on the current position and type (using evaluatePosition(...))*/
generateList(Cols, Rows, Type, Res, List) :- Cols > 0, (Type="None" ; not(evaluatePosition(Cols, Rows, Type))), NewCols is Cols - 1,  generateList(NewCols, Rows, Type, [0|Res], List).
generateList(Cols, Rows, Type, Res, List) :- Cols > 0, evaluatePosition(Cols, Rows, Type), NewCols is Cols - 1,  generateList(NewCols, Rows, Type, [1|Res], List).


/*** PRED ***/


/*Returns true if there has to be a one on the specified point, based on the type 
* Type is (S; A; N; C)
* Remember the way to read the indexes: list[0] = list[4] and list[3] = list[1]
*/
evaluatePosition(Column, Row, Type) :-   (Type = "S" , ( (even(Row), Column < 3) ; (not(even(Row)), Column > 2) )) ;
					 (Type = "A" , ( (not(even(Row)), Column > 1, Column < 4) ; (even(Row) , (Column < 2 ; Column > 3)) )) ;
					 (Type = "N" , ( (Row < 3, even(Column)) ; (Row > 2, not(even(Column))) )) ;
					 (Type = "C" , ( ((Row < 2 ; Row > 3), even(Column)) ; (Row > 1 , Row < 4, not(even(Column))) )).    


/*** PRED ***/


/*Returns true if the number is even
*/
even(N):- 0 is N mod 2.


/*** PRED ***/


/*Multiply a matrix by a scalar.
*/
scalarProd(N,M,L):-scalarProd(N,M,[],L).
scalarProd(_,[],L,L).
scalarProd(N,[H|T],NL,L):- number(H), B is N*H, append(NL,[B],Tmp), scalarProd(N,T,Tmp,L).
scalarProd(N,[H|T],NL,L):- is_list(H), scalarProd(N,H,[],R), append(NL,[R],Tmp), scalarProd(N,T,Tmp,L).


/*** PRED ***/


/*Adds the elements of two matrix.
*/
matrixSum(A,B,L):-matrixSum(A,B,[],L).
matrixSum([],[],L,L).
matrixSum([AH|AT],[BH|BT],R,L):-number(AH), number(BH), RT is AH+BH, append(R,[RT],Tmp), matrixSum(AT,BT,Tmp,L).
matrixSum([AH|AT],[BH|BT],R,L):-is_list(AH), is_list(BH), matrixSum(AH,BH,[],RT), append(R,[RT],Tmp), matrixSum(AT,BT,Tmp,L).


/*** PRED ***/


lengthM(M,N):-lengthM(M,0,N).
lengthM([],N,N).
lengthM([_|T],N,R):- NN is N+1, lengthM(T,NN,R).

generateAll(H):- createAllBases(A), reflectAll(A,B), rotateAll(B,C), rotateAllRows(C,D), rotateAllCols(D,E), rotateAllAtCenter(E,F), globalConvolution(F,G), lastCheck(G,H).

lastCheck(S,M):-lastCheck(S,[],M).
lastCheck([],M,M):- !.
lastCheck([H|T],M,NM):- (checkColsNRows(H), txTCornerCheck(H), checkTwoxTwoSquares(H), isnt(M,H),  lastCheck(T,[H|M],NM)) ; lastCheck(T,M,NM).

isnt([],_).
isnt([H|T],E):- not(E= H), isnt(T,E).

getFirsts(M,L,NM):- getFirsts(M,[],L,[],NM).
getFirsts([],L,L,NM,NM).
getFirsts([H|T],R,L,M,NM):- firstOut(H,HH,HT), append(R,[HH],NR), append(M,[HT],MM), getFirsts(T, NR, L, MM,  NM).
rotation(M,NM):- rotation(M,[],NM).
rotation([[]|_],NL,NL).
rotation(M,R,NM):- getFirsts(M,F,MM), append(R,[F],NR), rotation(MM,NR,NM).
rotateAll(M,NM):- rotateAll(M,[],NM).
rotateAll([],NM,NM):-!.
rotateAll([H|T],R,NM):- rotation(H,A), rotation(A,B), rotation(B,C), append([H],[A],TmpZ), append([B],[C],TmpO), append(TmpZ,TmpO,TmpT), append(R,TmpT,NR), rotateAll(T,NR,NM).
			


rotateAllRows(M,NM):-rotateAllRows(M,[],NM).
rotateAllRows([],NM,NM).
rotateAllRows([H|T],R,NM):- rotationOfRows(H,NH),rotationOfCols(NH,NNH),rotationOfCols(NNH,NNNH), append([NH],[H],A), append([NNH],[NNNH],B), append(A,B,Tmp), append(R,Tmp,NR), rotateAllRows(T,NR,NM).

rotateAllCols(M,NM):-rotateAllCols(M,[],NM).
rotateAllCols([],NM,NM).
rotateAllCols([H|T],R,NM):- rotationOfCols(H,NH),rotationOfCols(NH,NNH),rotationOfCols(NNH,NNNH), append([H],[NH],A),  append([NNH],[NNNH],B), append(A,B,Tmp), append(Tmp,R,NR),rotateAllCols(T,NR,NM).

rotateAllAtCenter(M,NM):-rotateAllAtCenter(M,[],NM).
rotateAllAtCenter([],NM,NM).
rotateAllAtCenter([H|T],R, NM):- rotationAtCenter(H,NH), ( (isnt(R,NH), append([NH],[H],A), append(A,R,NR), rotateAllAtCenter(T,NR,NM)) ; (append([H],R,NR) , rotateAllAtCenter(T,NR,NM)) ).

reflectAll(M,NM):-reflectAll(M,[],NM).
reflectAll([],NM,NM).
reflectAll([H|T],R, NM):- reflexion(H,NH), ( (isnt(R,NH), append([NH],[H],A), append(A,R,NR), reflectAll(T,NR,NM)) ; (append([H],R,NR),reflectAll(T,NR,NM)) ).

globalConvolution(M,NM):-globalConvolution(M,[],NM).
globalConvolution([],NM,NM).
globalConvolution([H|T],R, NM):- convolution(H,NHO), convolution(NHO,NHT), append([H],R,NR),
				((isnt(R,NHO), isnt(R,NHT), append([NHO],[NHT],NHOT), append(NHOT,NR,NNR), globalConvolution(T,NNR,NM));
				(isnt(R,NHO), append([NHO],NR,NNR), globalConvolution(T,NNR,NM)); 
				(isnt(R,NHT), append([NHT],NR,NNR), globalConvolution(T,NNR,NM)); 
				globalConvolution(T,NR,NM) ).

createAllBases(M):- createAllBases([],M,0).
createAllBases(M,M,3).
createAllBases(R,M,I):- I<3, NI is I+1, createSquare(I,H), createAllBases([H|R],M,NI).


/*Generates a base square using SANC method.
*/
createSquare(Type,L):- number(Type), generateMatrix("S",S), generateMatrix("A",A), generateMatrix("N",N), generateMatrix("C",C),
			(
				(Type = 0, scalarProd(8,S,NS),scalarProd(1,A,NA),scalarProd(4,N,NN),scalarProd(2,C,NC));
				(Type = 1, scalarProd(8,S,NS),scalarProd(2,A,NA),scalarProd(4,N,NN),scalarProd(1,C,NC));
				(Type = 2, scalarProd(8,S,NS),scalarProd(4,A,NA),scalarProd(2,N,NN),scalarProd(1,C,NC))
			),
			matrixSum(NS,NA,TmpOne), matrixSum(NN,NC,TmpTwo), matrixSum(TmpOne,TmpTwo,TmpThree), callocMatrix(4,1,I),  matrixSum(TmpThree,I,L).


/*** PRED ***/


/*Checks the sum of the columns and rows.
* L is used as a partial result. When the reicived list is empty, L has to be full of 30s.
* CkeckRows is aux.
*/
checkColsNRows(M):- generateList(4,0,"None",L), checkColsNRows(M,L).
checkColsNRows([],[]).
checkColsNRows([],[34|RColT]):- checkColsNRows([],RColT).
checkColsNRows([H|T],RCol):- checkRows(H,0), matrixSum(H,RCol,Tmp),  checkColsNRows(T,Tmp).


/*Checks the sum of the rows
* RRow is used as partial result. Whe the reicived list is empty, RRow has to be equal to 34.
* It also proofs that adjacent pairs and 2x2 subsquares sums 34
*/ 
checkRows([],34).
checkRows([H|T],RRow):- Tmp is RRow+H, checkRows(T,Tmp).


/*** PRED ***/


/*Generates a MxN or MxM matrix with the specified element(chr)
*/
callocMatrix(M,Chr,L):-callocMatrix(M,M,Chr,[],L).
callocMatrix(M,N,Chr,L):-callocMatrix(M,N,Chr,[],L).
callocMatrix(0,_,_,L,L).
callocMatrix(M,N,Chr,R,L):- B is M-1, callocList(N,Chr,T), callocMatrix(B,N,Chr,[T|R],L).
callocList(N,Chr,L):-callocList(N,Chr,[],L).
callocList(0,_,L,L).
callocList(N,Chr,R,L):- B is N-1, callocList(B,Chr,[Chr|R],L).

tmpShowAll(X,M):- callocMatrix(4,1,Tmp), tmpShowAll(X,Tmp,[],M).
tmpShowAll(0,_,M,M):-!.
tmpShowAll(X,Elem,R,M):- NX is X-1, append(R,[Elem],NR), tmpShowAll(NX,Elem,NR,M).


/*** PRED ***/


/*Reverse
*/
reverseList(X,L):-reverseList(X,[],L).
reverseList([],L,L).
reverseList([H|T],R,L):-reverseList(T,[H|R],L).


/*** PRED ***/


/*Reflects the matrix
*/
reflexion(S,NS):- reflexion(S,[],T), reverseList(T,NS).
reflexion([],L,L).
reflexion([H|T],R,L):- reverseList(H,NH), reflexion(T,[NH|R],L).


/*** PRED ***/


/*Takes the head
*/
firstOut(L,E,NL):-firstOut(L,[],E,NL,_).
firstOut(NL,E,E,NL).
firstOut([H|T],[],E,NL,_):-firstOut(T,H,E,NL).


/*** PRED ***/


/*Puts the tail at head
*/
lastAtFirst(L,NL):- lastAtFirst(L,[],NL).
lastAtFirst([],NL,NL).
lastAtFirst([H|T],R,NL):- T = [], lastAtFirst([],[H|R],NL).
lastAtFirst([H|T],R,NL):- not(T = []), append(R,[H],Tmp), lastAtFirst(T,Tmp,NL).


/*** PRED ***/


/*Puts the head at tail and the tail at head
*/
reverseHeadAndTail(L,NL):- firstOut(L,H,TmpOne), lastAtFirst(TmpOne, TmpTwo), append(TmpTwo,[H],NL).


/*** PRED ***/


/*Puts the last row where the first row goes
*/
rotateRow(L,NL):-lastAtFirst(L,NL).
rotationOfRows(S,NS):-rotationOfRows(S,[],NS).
rotationOfRows([],NL,NL).
rotationOfRows([H|T],R,NL):-rotateRow(H,NH),append(R,[NH],NR), rotationOfRows(T,NR,NL).

/*** PRED ***/


/*Puts the last column where the first column goes
*/
rotationOfCols(S,NS):-rotationOfCols(S,[],NS).
rotationOfCols([],NS,NS).
rotationOfCols([SH|ST],R,NS):- lastAtFirst(SH,NSH), append(R,[NSH],NR), rotationOfCols(ST,NR,NS).



/*** PRED ***/


/*Checks if the corners of the four 3x3 squares sums 34
*/
txTCornerCheck(S):- txTCornerCheck(S,0,0,0,0,0).
txTCornerCheck([],RO,RT,RTH,RF,RO,RT,RTH,RF,_,4):-!.
txTCornerCheck([SH|ST],ROne,RTwo,RThree,RFour,RO,RT,RTH,RF,I,J):- even(I), even(J), Tmp is ROne+SH, NJ is J+1, txTCornerCheck(ST,Tmp,RTwo,RThree,RFour,RO,RT,RTH,RF,I,NJ).
txTCornerCheck([SH|ST],ROne,RTwo,RThree,RFour,RO,RT,RTH,RF,I,J):- even(I), not(even(J)), Tmp is RTwo+SH, NJ is J+1, txTCornerCheck(ST,ROne,Tmp,RThree,RFour,RO,RT,RTH,RF,I,NJ).
txTCornerCheck([SH|ST],ROne,RTwo,RThree,RFour,RO,RT,RTH,RF,I,J):- not(even(I)), even(J), Tmp is RThree+SH, NJ is J+1, txTCornerCheck(ST,ROne,RTwo,Tmp,RFour,RO,RT,RTH,RF,I,NJ).
txTCornerCheck([SH|ST],ROne,RTwo,RThree,RFour,RO,RT,RTH,RF,I,J):- not(even(I)), not(even(J)), Tmp is RFour+SH, NJ is J+1, txTCornerCheck(ST,ROne,RTwo,RThree,Tmp,RO,RT,RTH,RF,I,NJ).
txTCornerCheck([],34,34,34,34,4):-!.
txTCornerCheck([SH|ST],ROne,RTwo,RThree,RFour,I):- I<4, NI is I+1, txTCornerCheck(SH,ROne,RTwo,RThree,RFour,RO,RT,RTH,RF,I,0), txTCornerCheck(ST,RO,RT,RTH,RF,NI).


/*** PRED ***/


/*Creates three digits corresponding to three 2x2 squares that are made by two 4x4 lists.
*/
createSquaresFromLists(_,[]).
createSquaresFromLists(A,B):-createSquaresFromLists(A,B,0,0,0,0).
createSquaresFromLists([],[],4,34,34,34).
createSquaresFromLists([AH|AT],[BH|BT],I,X,Y,Z):- NI is I+1,
							((I=0, Tmp is X+AH+BH, createSquaresFromLists(AT,BT,NI,Tmp,Y,Z)) ;
							(I=1, TmpO is X+AH+BH, TmpT is Y+AH+BH, createSquaresFromLists(AT,BT,NI,TmpO,TmpT,Z)) ;
							(I=2, TmpO is Y+AH+BH, TmpT is Z+AH+BH, createSquaresFromLists(AT,BT,NI,X,TmpO,TmpT)) ;
							(I=3, Tmp is Z+AH+BH, createSquaresFromLists([],[],NI,X,Y,Tmp))).
/*Checks the sums of the 2x2 subsquares
*/
checkTwoxTwoSquares([_|ST]):- ST = [].
checkTwoxTwoSquares([SH|ST]):- firstOut(ST,STH,_), createSquaresFromLists(SH,STH), checkTwoxTwoSquares(ST).


/*** PRED ***/


/*Gets the last element of a list
*/
getLast(L,E):- getLast(L,[],E).
getLast([],E,E).
getLast([H|T],_,E):-getLast(T,H,E).

/*Realize the swap of the rotation at center point
*/
pseudoSwap(A,B,NA,NB):- pseudoSwap(A,B,_,[],NA,[],NB,0). 
pseudoSwap([],[],_,A,A,B,B,_).
pseudoSwap([AH|AT],[BH|BT],T,NA,A,NB,B,J):- NJ is J+1,
						(
					 	 (J=0, append(NA,[AH],TmpA), firstOut(AT,ATH,_), append(NB,[ATH],TmpB),pseudoSwap(AT,BT,BH,TmpA,A,TmpB,B,NJ));
					 	 (J=1, append(NA,[T],TmpA), append(NB,[BH],TmpB),pseudoSwap(AT,BT,AH,TmpA,A,TmpB,B,NJ));
					 	 (J=2, getLast(BT,Tmp), append(NA,[Tmp],TmpA), append(NB,[BH],TmpB),pseudoSwap(AT,BT,AH,TmpA,A,TmpB,B,NJ));
					 	 (J=3, append(NA,[AH],TmpA), append(NB,[T],TmpB),pseudoSwap(AT,BT,AH,TmpA,A,TmpB,B,NJ))
						).

/*Rotates at center point
*/
rotationAtCenter([H|T],NS):- 	firstOut(T,HH,NT), firstOut(NT,HHH,NNT), firstOut(NNT,HHHH,_), 
				pseudoSwap(H,HH,NH,NHH), pseudoSwap(HHHH,HHH,NHHHH,NHHH),  
				append([NH],[NHH],TmpOne),append([NHHH],[NHHHH],TmpTwo),append(TmpOne,TmpTwo,NS).


/*** PRED ***/


convolutionAux([AH|AT],[BH|BT],NA,NB):-	 lastAtFirst(AT,NAT), firstOut(NAT,AHH,CA), append([AH],[AHH],EA),
					 lastAtFirst(BT,NBT), firstOut(NBT,BHH,CB), append([BH],[BHH],EB),
					 reverseList(EB,NEB), reverseList(CB,NCB), append(EA,NEB,NA), append(CA,NCB,NB).
convolution([H|T],NS):- firstOut(T,HH,NT), firstOut(NT,HHH,NNT), firstOut(NNT,HHHH,_),
			convolutionAux(H,HH,NH,NHH),convolutionAux(HHH,HHHH,NHHH,NHHHH), 
			reverseList(NHHH,NHHHR), reverseList(NHHHH,NHHHHR), 
			append([NH],[NHH],TmpOne), append([NHHHHR],[NHHHR],TmpTwo), append(TmpOne, TmpTwo, NS).
