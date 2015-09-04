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
        String path = new File("Program/Backend/diabolicMagicSquareBackend.pl")
                .getAbsolutePath();
        System.out.println(path);
        Query q1 =
                new Query(
                        "consult",
                        new Term[] {new Atom(path)}
                );

        System.out.println("Consult " + (q1.hasSolution() ? "succeeded" : "failed"));

        MagicSquares.main();



    }

}
