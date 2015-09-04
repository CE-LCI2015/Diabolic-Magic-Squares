# COSTA RICA INSTITUTE OF TECHNOLOGY

**- Computer Engineering**

**- Programming Languages, Compilers and Interpreters**

**- Relational Database**

**- Project by: Roberto Bonilla and Pablo Rodríguez**






# Introduction
Prolog is the most popular logical language. As part of this project we are going to learn how
to program in a logical language and link it with Java programming language. This was done in order to control
the program with two different aspects, the frontend and the backend. The backend, done in Prolog, manages the logic of
the program. This aspect controls the generation and validation, and performs all the diverse functions handling the
diabolic magic squares. On the other hand, the frontend, done in Java, controls and manages the interaction with the user.
It receives all the inputs and request of the user and then makes a brigde to the backend. Then after the backend performs
all the functions the frontend,Java, receives the results and displays then to the user in a friendly and elegant way.
Making it much easier for the user to interact with the program.


# Problem Description
A diabolical magic square is a magic square with the additional property that the broken diagonals also add up to the magic constant.
In a 4x4 diabolic magic square,the magic constant 34 ((n^3 + n)/2) can be seen in a
number of patterns in addition to the rows, columns and diagonals:

* Any of the sixteen 2x2 squares, including those that wrap around the edges of the whole square.

* The corners of any 3×3 square.

* Any pair of horizontally or vertically adjacent numbers, together with the  corresponding pair displaced by a (2, 2) vector.

Each nxn “diabolic magic square” can have 8*n^2 orientations. In the case of the 4x4
diabolic magic squares, can have up to three distinct squares,
Performing several operation to the three disctinct squares you can get many different squares.
The problem is that we need all the possible matrices that apply as a diabolic magic square. In order to do this. We use prolog
to generate the three main matrices and then permutate to obtain all the possibilities.

# User Guide

To use the program you need to install swi-prolog with jpl under an eviroment of GNU/Linux. Also you need to install Java to execute the frontend.
We are using the IDE Intellij for java and swi-prolog for prolog. The intention to use java for the frontend was to do a simple yet effective GUI.
This interface, friendly user, provides diferrent screens and options for verification, request, inputs and outputs.

* For verifying a matrix as a diabolic magic square the user inputs the matrix by entering each of the sixteen numbers one by one and clicking on verify.
A popup message will display in case of error, explainig what and where the error is.

![Verify Example](http://s9.postimg.org/zb4bqzidr/verify.png)


 **Example of verify**


*For generating a certain amount of matrices the user just press the button generate,this will give the user the chance to input a number from a range of 1 to 10,
The program provides a screen which allows the user to see all the matrices he requested.
In this screen as well, a message will pop up in case of error, explainig what and where the error is.

![Generate Example](http://s3.postimg.org/42xxee2k3/Screenshot_from_2015_09_03_21_59_33.png)


 **Example of generate**

* For showing all the possible 384 matrices the user has the option named "showall" which displays a screen with all the matrices arranged in an nice and orderly way.

![Showall Example](http://s16.postimg.org/6dreybhcl/showall.png)


 **Example of show all**


Finally, the GUI provides the exit button to finalize the interaction whenever the user wants it.




 
# Development Environment
Intellij : an IDE for java development and GUI Development.
Swi-Prolog : a development kit for working with prolog.



# Program Design

The Diabolic Magic Squares Generator generates three different squares using the SANC method.
The SANC method consists on building four different matrixes: S, A, N and C. Each of those matrixes are multiplied by a integer (1, 2, 4 or 8) in a specific order and their sum generates a Diabolic Magic Square. This method produces 24 squares that are variations of the 3 main squares. To get a specific number of squares, N of those 24 squares are selected, where N has a value between one and ten.
There are seven allowed permutations:

* Reflection: reverse all the elements of the rows.
* Rotation about the center point: the middle elements of the extern rows, becomes the extern elements of the middle rows
* Rotation of columns: the first column becomes the last.
* Rotation of columns: the first column becomes the last.
* Convolution: a row becomes a 2x2 squares. The top rows are mixed, also the bottom rows.
* Inserted columns swap: the first column becomes the third and the second becomes the last.
* Inserted rows swap: the first row becomes the third and the second becomes the last.

Using those permutatios and storing the results is possible to generate the 384 squares, that is the easiest way we found.


From these three basic squares all of the other possible squares can be made.
 There are sixteen cells in each square so, just by translocation,
 there are sixteen variations of each square. Each of these translocations can be rotated into four different positions,
  and each rotation can be reflected. Therefore, 3 x 16 x 8 = 384 regular, order four, pan-magic squares can be derived
  from these three basic squares.

  The project FrontEnd was designed in Java because the integration of swi-prolog through the library JPL. This library provides a
  well documented interface to prolog and well known also. The GUI design is easier , it saves time and increases productivity. But it decreases
  the efficiency of the program unfortunately.

# Student's Activity Log

**Roberto Bonilla**

| Activity                    | Description                           | Time(h) |
|:---------------------------:|:-------------------------------------:|:-------:|
|Meeting with Pablo           | Discussion and research               |   1     |
|Research                     | Building methods and permutations     |   3     |
|Development                  | SANC Matrix builder for the generator |   2     |
|Development                  | Generator and analyzer                |   2     |
|Development                  | Permutations                          |   4     |
|Development                  | ShowAll                               |   6     |

Time sum: 18 h.

**Pablo Rodriguez**

Duration      | Activity      | Description
------------- | ------------- | -------------
1h | Meeting  | Discussing th project with Roberto
4h | Research | Learning the basics of Prolog
3h | Research | Learning about the Diabolic Magic Squares
3h | Coding   | Programming some basic validation of magic squares
3h | Research | Configuring swi-prolog with java
3h | Coding   | Programing the GUI of java swing

# Project Final Status
The program meets all the requirements specified. It verifies if a diabolic magic square entered by the user is really one or not.
It allows the user to request the generation of 1 to 10 diabolic magic squares and displays them back to them.
Finally, the program displays all the 384 diabolic magic squares in a screen which makes it easy for the user to visualize them all.
The program makes all the necessary validations to secure the perfect functionality, and in case there is an error caused by the user the program displays
all the messages indicating what the error is and when it applies the specific location of it.

# Conclusions

Prolog is a good lenguage for logical designs. It provides the a lot of tools to solve inferences that helps on decisions and mathematical algorithms.
With logic programming we can code with backtracking simulating the human brain used in artificial intelligence.
The uses of backtracking are limitless as we kniow, we can generate 384 matrices from premisas.

# Suggestions and recommendations
* Use a GUI Designer to improve the time of creation.
* In prolog use many functions as necessary to ensure readability.
* Use a version control to organize your code
* Anticipate all kind of problems, so your program dont crash.
* Do not edit code minutes previous to the  deadline.

# References

* Weisstein, Eric W. "Panmagic Square." From MathWorld--A Wolfram Web Resource. http://mathworld.wolfram.com/PanmagicSquare.html
* W. S. Andrews, Magic Squares and Cubes. New York: Dover, 1960. Originally printed in 1917. See especially Chapter X.
* Wikipedia. Wikimedia Foundation, n.d. Web. 4 Sept. 2015. https://en.wikipedia.org/wiki/Pandiagonal_magic_square
* "The 4x4 Pan-Magic Squares." The 4x4 Pan-Magic Squares. N.p., n.d. Web. 04 Sept. 2015.  http://www.grogono.com/magic/4x4.php
* "The Basics of Prolog." The Basics of Prolog. N.p., n.d. Web. 04 Sept. 2015.  http://www.dipmat.unict.it/~barba/PROG-LANG/PROGRAMMI-TESTI/READING-MATERIAL/BasicsOfProlog
* "Low-Level Interface." Low-Level Interface. N.p., n.d. Web. 04 Sept. 2015.  http://www.swi-prolog.org/packages/jpl/java_api/low-level_interface.html
* "Trail: Creating a GUI With JFC/Swing." (The Java™ Tutorials). N.p., n.d. Web. 04 Sept. 2015.  http://docs.oracle.com/javase/tutorial/uiswing/
* "LEARNING PROLOG VIA EXAMPLES." Prolog Guide: Learning. N.p., n.d. Web. 04 Sept. 2015. http://kti.ms.mff.cuni.cz/~bartak/prolog.old/learning.html
* "CSC485 / CSC 2501 Prolog Basics." CSC485 / CSC 2501 Prolog Basics. N.p., n.d. Web. 04 Sept. 2015. http://www.cs.toronto.edu/~dianaz/2501/prologBasics.html