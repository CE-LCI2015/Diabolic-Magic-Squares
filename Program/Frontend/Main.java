package Frontend;
import Frontend.GUI.MagicSquares;
import Frontend.GUI.ShowMatrix;
import org.jpl7.Atom;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

import javax.swing.*;
import java.io.File;

/**
 * Created by pablo on 28/08/15.
 */
public class Main {
    public static void main(String[] args) {
        String path = new File("Program/Backend/generator.pl")
                .getAbsolutePath();
        System.out.println(path);
        Query q1 =
                new Query(
                        "consult",
                        new Term[] {new Atom(path)}
                );

        System.out.println("Consult " + (q1.hasSolution() ? "succeeded" : "failed"));

        //int[][] test = {{1,8,13,12},{14,11,2,7},{4,5,16,9},{15,10,3,6}};
        //PrologQueries.checkDiabolic(test);
        //int length =384;
        //int [][][] list = new int[length][4][4];
        //int[][] listt ={{0,1,2,3},{1,2,3,4},{2,3,4,5},{3,4,5,6}};
        //for (int i = 0; i < length; i++) {
        //    list[i] = listt;
        //}


        //ShowMatrix.main(list);

        MagicSquares.main();



    }

}
