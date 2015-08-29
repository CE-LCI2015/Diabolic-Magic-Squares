/*** PRED ***/


/*Generates a SANC matrix
* Type is (S; A; N; C)
*/
generateMatrix(Type, Matrix) :- generateMatrix(4, 4, Type, [], Matrix).

/*Stops the process*/
generateMatrix(Cols, 0, Type, Matrix, Matrix) :- !.

/*Generates a line*/
generateMatrix(Cols, Rows, Type, Res, Matrix) :- Rows > 0, NewRows is Rows - 1, generateList(Cols, Rows, Type, NewRow), generateMatrix(Cols, NewRows, Type, [NewRow|Res], Matrix).


/*** PRED ***/


/*Generates a list with ones and zeros depending on the type
* Type is (S; A; N; C)
* Rows and Cols goes from list[4] to list[1], so there is no list[0]
*/
generateList(Cols, Rows, Type, List) :- generateList(Cols, Rows, Type, [], List).

/*Stops the process*/

generateList(0, Rows, Type, List, List) :- !.

/*Fills the line with a one or a zero, based on the current position and type (using evaluatePosition(...))*/
generateList(Cols, Rows, Type, Res, List) :- Cols > 0, not(evaluatePosition(Cols, Rows, Type)), NewCols is Cols - 1,  generateList(NewCols, Rows, Type, [0|Res], List).
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


scalarProd(N,M,L):-scalarProd(N,M,[],L).
scalarProd(N,[],L,L):-!.
scalarProd(N,[H|T],NL,L):- number(H), B is N*H, append(NL,[B],Tmp), scalarProd(N,T,Tmp,L).
scalarProd(N,[H|T],NL,L):- is_list(H), scalarProd(N,H,[],R), append(NL,[R],Tmp), scalarProd(N,T,Tmp,L).


/*** PRED ***/


matrixSum(A,B,L):-matrixSum(A,B,[],L).
matrixSum([],[],L,L):-!.
matrixSum([AH|AT],[BH|BT],R,L):-number(AH), number(BH), RT is AH+BH, append(R,[RT],Tmp), matrixSum(AT,BT,Tmp,L).
matrixSum([AH|AT],[BH|BT],R,L):-is_list(AH), is_list(BH), matrixSum(AH,BH,[],RT), append(R,[RT],Tmp), matrixSum(AT,BT,Tmp,L).


/*** PRED ***/


createSquare(Type,L):- number(Type), generateMatrix("S",S), generateMatrix("A",A), generateMatrix("N",N), generateMatrix("C",C),scalarProd(8,S,NS),
			(
				(Type = 0, scalarProd(1,A,NA),scalarProd(4,N,NN),scalarProd(2,C,NC));
				(Type = 1, scalarProd(2,A,NA),scalarProd(4,N,NN),scalarProd(1,C,NC));
				(Type = 2, scalarProd(4,A,NA),scalarProd(2,N,NN),scalarProd(1,C,NC))
			),
			matrixSum(NS,NA,TOne), matrixSum(NN,NC,TTwo), matrixSum(TOne,TTwo,L).

