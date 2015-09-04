package Frontend;

import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Util;

import java.util.HashMap;


/**
 * Created by pablo on 28/08/15.
 */

/**
 * THis class provides utilities
 */
public class PrologQueries {

    /**
     * Check if a matrix is diabolic
     * @param matrix to be tested
     * @return boolean if is a diabolic
     */
    static public boolean checkDiabolic(int[][] matrix)
    {
        Term t = Util.intArrayArrayToList(matrix);
        Query q = new Query("diabolicMatrix", t);
        System.out.println("Diabolic matrix?: "+q.hasSolution());
        return q.hasSolution();
    }

    /**
     * Returns the matrix of all the 384 results
     * @return
     */
    static public int[][][] showall()
    {

        Query q = new Query("generateAll(X)");
        Term[] listSols =q.oneSolution().get("X").toTermArray();
        int[][][] result = getMatrix(listSols);
        return result;
    }

    /**
     * Auxiliar function
     * @param listSols
     * @return
     */
    private static int[][][] getMatrix(Term[] listSols) {
        int[][][] result = new int[listSols.length]
                [listSols[0].toTermArray().length]
                [listSols[0].toTermArray()[0].toTermArray().length];
        for (int k = 0; k < listSols.length; k++) {
            Term[] rows = listSols[k].toTermArray();
            for (int j = 0; j < rows.length; j++) {
                Term[] eles = rows[j].toTermArray();
                for (int i = 0; i < eles.length; i++) {
                    result[k][j][i] =eles[i].intValue();
                }
            }
        }
        return result;
    }

    /**
     * Generate matrices depending of the number n
     * @param n number of matrices
     * @return the matrices result
     */
    static public int[][][]generate(int n)
    {

        Query q = new Query("generateMagicSquares("+n+", X)");
        Term[] listSols =q.oneSolution().get("X").toTermArray();
        int[][][] result = getMatrix(listSols);
        return result;
    }
}

