package Frontend;

import org.jpl7.*;

/**
 * Created by pablo on 28/08/15.
 */
public class PrologQueries {
    static public boolean checkDiabolic(int[][] matrix)
    {
        Term t = Util.intArrayArrayToList(matrix);
        Query q = new Query("diabolic", t);
        System.out.println("Diabolic matrix?: "+q.hasSolution());
        return q.hasSolution();
    }
    static public int[][][] showall()
    {
        Variable M = new Variable();
        Query q = new Query("", new Term[]{M});
        return null;
    }
}

