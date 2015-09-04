package Frontend.GUI;

import Frontend.PrologQueries;
import Frontend.Utils;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ContainerAdapter;
import java.awt.event.InputMethodListener;

/**
 * Created by pablo on 28/08/15.
 */
public class MagicSquares  {
    private JPanel matrix;
    private JTextField [][] textFields;
    private JTextField A1;
    private JTextField A4;
    private JTextField A2;
    private JTextField A3;
    private JTextField B1;
    private JTextField B2;
    private JTextField B3;
    private JTextField B4;
    private JTextField C1;
    private JTextField C2;
    private JTextField C3;
    private JTextField C4;
    private JTextField D1;
    private JTextField D2;
    private JTextField D3;
    private JTextField D4;
    private JButton generateButton;
    private JButton verifyButton;
    private JButton showAllButton;
    private JButton exitButton;

    /**
     * Main of gui
     */
    public MagicSquares() {
        JTextField[][] extFields = {{A1,A2,A3,A4},{B1,B2,B3,B4}, {C1,C2,C3,C4},{D1,D2,D3,D4}};
        textFields = extFields;
        exitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                System.exit(0);
            }

        });

        verifyButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                checkMatrix();
            }
        });
        showAllButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                ShowMatrix.main(PrologQueries.showall());
            }
        });
        generateButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    String resultInString = JOptionPane.showInputDialog("How many squares to be generated?");
                    int result = Integer.parseInt(resultInString);
                    if (result<1||result>10) msgbox("You didn't give a number in range");
                    else
                    {
                        ShowMatrix.main(PrologQueries.generate(result));
                    }
                } catch (NumberFormatException e) {
                   msgbox("You didn't give a number");
                }
            }
        });
    }

    private void msgbox(String s){
        JOptionPane.showMessageDialog(null, s);
    }

    public static void main() {
        JFrame frame = new JFrame("MagicSquares2.0");
        frame.setContentPane(new MagicSquares().matrix);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    /**
     * Prepares matrix when verifying
     */
    void checkMatrix()
    {
        int[][] input = new int[4][4];
        System.out.println("Verify");
        for (int j = 0; j < textFields.length; j++) {
            for (int i = 0; i < textFields[0].length; i++) {
                JTextField component = textFields[j][i];
                String text = component.getText();
                if(text.equals(""))
                {
                    msgbox("Empty slot : "+ i + ", " + j );
                    return;
                }
                int value =0;
                try {
                    value = Integer.parseInt(text);
                } catch (NumberFormatException e) {
                    msgbox("Not a number in : "+ i + ", " + j );
                    return;
                }
                input[j][i] = value;

            }

        }
        System.out.println(Utils.stringify(input));
        if(PrologQueries.checkDiabolic(input))
        {
            msgbox("Congrats, it is a Diabolic Magic Square :)");
        }
        else
        {
            msgbox("It's not a Diabolic Magic Square :(");
        }

    }
}
