import javax.swing.*;

public class Main {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Pacman Game");
        GamePanel panel = new GamePanel();

        frame.add(panel);
        frame.setSize(600, 600); // Adjust size based on maze
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}
