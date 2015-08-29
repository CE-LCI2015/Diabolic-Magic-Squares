

/*** PRED ***/


/*Tells if it is a Diabolic magic square
*/

diabolic(Matrix) :- checkRows(Matrix).



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


/*Generates a base square using SANC method.
*/
createSquare(Type,L):- number(Type), generateMatrix("S",S), generateMatrix("A",A), generateMatrix("N",N), generateMatrix("C",C),scalarProd(8,S,NS),
			(
				(Type = 0, scalarProd(1,A,NA),scalarProd(4,N,NN),scalarProd(2,C,NC));
				(Type = 1, scalarProd(2,A,NA),scalarProd(4,N,NN),scalarProd(1,C,NC));
				(Type = 2, scalarProd(4,A,NA),scalarProd(2,N,NN),scalarProd(1,C,NC))
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
*/ 
checkRows([],34).
checkRows([H|T],RRow):- Tmp is RRow+H,checkRows(T,Tmp).


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
