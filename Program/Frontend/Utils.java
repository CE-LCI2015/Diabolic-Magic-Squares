package Frontend;

/**
 * Created by pablo on 28/08/15.
 */
public class Utils {
    /**
     * Converts matrix to string
     * @param matrix
     * @return
     */
    static public String stringify(int[][]matrix)
    {
        String result = "";
        result += ("[");
        for (int j = 0; j < matrix.length; j++) {
            result+=("[");
            for (int i = 0; i < matrix[0].length; i++) {
                result+=(String.valueOf(matrix[j][i]));
                if(i < matrix[0].length-1) result+=(", ");
            }
            result+=("]");
            if(j < matrix.length-1) result+=(", ");
        }
        result+=("]");
        return result;
    }
}
