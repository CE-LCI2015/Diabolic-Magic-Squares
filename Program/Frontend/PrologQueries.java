package Frontend;

import org.jpl7.Atom;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;
/**
 * Created by pablo on 28/08/15.
 */
public class PrologQueries {
    static public boolean checkDiabolic(int[][] matrix)
    {
        Query q =
                new Query(
                        "diabolic",
                        new Term[] {new Atom(Utils.stringify(matrix))}
                );
        return false;
    }
}
