package Frontend.GUI;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

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

    public MagicSquares() {
        JTextField[][] extFields = {{A1,A2,A3,A4},{B1,B2,B3,B4}, {C1,C2,C3,C4},{D1,D2,D3,D4}};
        textFields = extFields;
        exitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                System.exit(0);
            }

        });

    }
    

    public static void main() {
        JFrame frame = new JFrame("MagicSquares");
        frame.setContentPane(new MagicSquares().matrix);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

}
