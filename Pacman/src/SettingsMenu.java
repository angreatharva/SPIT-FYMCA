import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SettingsMenu extends JFrame {
    private JComboBox<String> difficultyCombo;
    private JSlider speedSlider;

    public SettingsMenu() {
        setTitle("Pacman Settings");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 200);
        setLocationRelativeTo(null);

        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        // Difficulty Selection
        JPanel difficultyPanel = new JPanel();
        difficultyPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
        JLabel difficultyLabel = new JLabel("Difficulty:");
        String[] difficulties = {"easy", "medium", "hard"};
        difficultyCombo = new JComboBox<>(difficulties);
        difficultyCombo.setSelectedItem("medium");
        difficultyPanel.add(difficultyLabel);
        difficultyPanel.add(difficultyCombo);

        // Ghost Speed Selection
        JPanel speedPanel = new JPanel();
        speedPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
        JLabel speedLabel = new JLabel("Ghost Speed:");
        speedSlider = new JSlider(JSlider.HORIZONTAL, 1, 5, 1);
        speedSlider.setMajorTickSpacing(1);
        speedSlider.setPaintTicks(true);
        speedSlider.setPaintLabels(true);
        speedPanel.add(speedLabel);
        speedPanel.add(speedSlider);

        // Start Button
        JButton startButton = new JButton("Start Game");
        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                startGame();
            }
        });

        panel.add(difficultyPanel);
        panel.add(Box.createVerticalStrut(20));
        panel.add(speedPanel);
        panel.add(Box.createVerticalStrut(20));
        panel.add(startButton);

        add(panel);
        setVisible(true);
    }

    private void startGame() {
        // Save settings
        GameSettings.setSetting("difficulty", difficultyCombo.getSelectedItem());
        GameSettings.setSetting("ghostSpeed", speedSlider.getValue());

        // Adjust ghost behavior based on difficulty
        switch ((String) difficultyCombo.getSelectedItem()) {
            case "easy":
                GameSettings.setSetting("ghostUpdateInterval", 15);
                GameSettings.setSetting("usePathfinding", false);
                break;
            case "medium":
                GameSettings.setSetting("ghostUpdateInterval", 10);
                GameSettings.setSetting("usePathfinding", true);
                break;
            case "hard":
                GameSettings.setSetting("ghostUpdateInterval", 5);
                GameSettings.setSetting("usePathfinding", true);
                break;
        }

        // Start the game
        SwingUtilities.invokeLater(() -> {
            JFrame gameFrame = new JFrame("Pacman Game");
            gameFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            gameFrame.setSize(580, 600);
            gameFrame.setLocationRelativeTo(null);
            gameFrame.add(new GamePanel());
            gameFrame.setVisible(true);
            dispose(); // Close the settings menu
        });
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new SettingsMenu());
    }
}