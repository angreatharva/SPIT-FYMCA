import javax.swing.*;
import java.awt.*;

public class AwtApp {

    public static void main(String[] args) {
        // Uncomment one of the following lines to test either AWT or Swing

//        new Awt();       // AWT GUI
        new SwingApp(); // Swing GUI
    }

    // AWT Class
    static class Awt extends Frame {
        Awt() {
            Label firstName = new Label("First Name");
            firstName.setBounds(20, 50, 80, 20);

            Label lastName = new Label("Last Name");
            lastName.setBounds(20, 80, 80, 20);

            Label dob = new Label("Date of Birth");
            dob.setBounds(20, 110, 80, 20);

            TextField firstNameTF = new TextField();
            firstNameTF.setBounds(120, 50, 100, 20);

            TextField lastNameTF = new TextField();
            lastNameTF.setBounds(120, 80, 100, 20);

            TextField dobTF = new TextField();
            dobTF.setBounds(120, 110, 100, 20);

            Button sbmt = new Button("Submit");
            sbmt.setBounds(20, 160, 100, 30);

            Button reset = new Button("Reset");
            reset.setBounds(120, 160, 100, 30);

            add(firstName);
            add(lastName);
            add(dob);
            add(firstNameTF);
            add(lastNameTF);
            add(dobTF);
            add(sbmt);
            add(reset);

            setSize(300, 250);
            setLayout(null);
            setVisible(true);
        }
    }

    // Swing Class
    static class SwingApp {
        SwingApp() {
            JFrame f = new JFrame("Swing Example");

            JLabel firstName = new JLabel("First Name");
            firstName.setBounds(20, 50, 80, 20);

            JLabel lastName = new JLabel("Last Name");
            lastName.setBounds(20, 80, 80, 20);

            JLabel dob = new JLabel("Date of Birth");
            dob.setBounds(20, 110, 80, 20);

            JTextField firstNameTF = new JTextField();
            firstNameTF.setBounds(120, 50, 100, 20);

            JTextField lastNameTF = new JTextField();
            lastNameTF.setBounds(120, 80, 100, 20);

            JTextField dobTF = new JTextField();
            dobTF.setBounds(120, 110, 100, 20);

            JButton sbmt = new JButton("Submit");
            sbmt.setBounds(20, 160, 100, 30);

            JButton reset = new JButton("Reset");
            reset.setBounds(120, 160, 100, 30);

            f.add(firstName);
            f.add(lastName);
            f.add(dob);
            f.add(firstNameTF);
            f.add(lastNameTF);
            f.add(dobTF);
            f.add(sbmt);
            f.add(reset);

            f.setSize(300, 250);
            f.setLayout(null);
            f.setVisible(true);
            f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        }
    }
}
