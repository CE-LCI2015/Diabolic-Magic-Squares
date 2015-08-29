package Frontend.GUI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Created by pablo on 29/08/15.
 */
public class ShowMatrix {
    private int counter;
    private int[][][] list;
    private JLabel[][][] labels;
    private JPanel matrixPanel;
    private JButton nextButton;
    private JPanel main;
    private JLabel counterLabel;

    public static void main(int[][][] matrixList) {
        JFrame frame = new JFrame("ShowMatrix");
        frame.setContentPane(new ShowMatrix(matrixList).main);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    public ShowMatrix(int[][][] pList) {
        counter=0;
        list = pList;
        labels = new JLabel[4][4][4];
        next();

        nextButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                next();
            }
        });
    }

    private void createLabels() {
        for (int k = 0; k <4; k++) {
            JPanel panel = new JPanel(new GridLayout(4, 4, 4, 4));
            for (int j = 0; j < 4; j++) {
                for (int i = 0; i < 4; i++) {
                    JLabel label = new JLabel("-");
                    panel.add(label);
                    labels[k][j][i] = label;
                }

            }
            matrixPanel.add(panel);
        }
    }

    public void next()
    {
        if(counter*4> list.length) return;
        if((counter+1)*4< list.length) counterLabel.setText((counter+1)*4 +" of " + list.length+" results");
        else counterLabel.setText((list.length +" of " + list.length+" results"));
        int max = list.length -counter*4;
        if (max>4)max = 4;
        for (int k = 0; k < 4; k++) {


            for (int i = 0; i <4; i++) {
                for (int j = 0; j < 4; j++) {
                    if(k<max)
                    {
                        labels[k][j][i].setText( list[counter*4 + k][j][i] + "");
                    }
                    else
                    {
                        labels[k][j][i].setText("-");
                    }

                }
            }


        }
        counter++;
    }

    private void createUIComponents() {
        matrixPanel = new JPanel(new GridLayout(2, 2, 5, 5));
        matrixPanel.setOpaque(true);
        matrixPanel.setBackground(Color.WHITE);
        createLabels();
        counterLabel = new JLabel("0 of 0 results");
    }
}
