package Frontend.GUI;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * Created by pablo on 29/08/15.
 */
public class ShowMatrix {
    private int[][][] list;
    private JLabel[][][] labels;
    private JPanel matrixPanel;
    private JButton quitButton;
    private JPanel main;
    private JLabel infoLabel;
    private JScrollPane matrixScrollPane;
    private JPanel counterPanel;
    private JLabel counterLabel;
    private static JFrame frame;

    /**
     * Starts a new gui for displaying results
     * @param matrixList the matrix list
     */
    public static void main(int[][][] matrixList) {
        frame = new JFrame("ShowMatrix");
        frame.setContentPane(new ShowMatrix(matrixList).main);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    /**
     * Constructor of the gui showing matrices
     * @param pList
     */
    public ShowMatrix(int[][][] pList) {

        list = pList;
        labels = new JLabel[list.length][4][4];


        quitButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                frame.dispose();
            }
        });
    }

    /**
     * Creatree the matrix
     */
    private void createLabels() {
        counterLabel.setText(list.length+" results");
        for (int k = 0; k <list.length; k++) {
            JPanel panel = new JPanel(new GridLayout(4 ,4 , 10, 4));
            for (int j = 0; j < 4; j++) {
                for (int i = 0; i < 4; i++) {
                    JLabel label = new JLabel(list[k][j][i] + "");
                    panel.add(label);
                    labels[k][j][i] = label;
                }

            }
            matrixPanel.add(panel);
        }
    }


    /**
     * Custrom create of labels and panel
     */
    private void createUIComponents() {
        int width = (int)Math.sqrt(list.length);
        if(width > 12) width = 12;
        int heigth = list.length/width;
        if(heigth*width<list.length) heigth++;
        matrixScrollPane = new JScrollPane(matrixPanel);
        matrixPanel = new JPanel(new GridLayout(heigth, width, 10, 10));
        matrixPanel.setOpaque(true);
        matrixPanel.setBackground(Color.WHITE);
        matrixScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        matrixScrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        counterPanel = new JPanel();
        counterLabel = new JLabel("Hola");
        counterPanel.add(counterLabel);
        createLabels();
    }
}
