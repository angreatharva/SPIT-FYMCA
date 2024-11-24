import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.List;

public class GamePanel extends JPanel implements ActionListener {
    private Timer timer;
    private Maze maze;
    private Pacman pacman;
    private List<Ghost> ghosts;
    private List<Pellet> pellets;
    private int score;
    private boolean gameInitialized;
    private boolean gameOver;
    private boolean collisionOccurred;

    public GamePanel() {
        maze = new Maze();
        pacman = new Pacman(1, 1);

        // Initialize ghosts with different colors and positions
        ghosts = new ArrayList<>();
        ghosts.add(new Ghost(13, 11, Color.RED));      // Blinky
        ghosts.add(new Ghost(14, 11, Color.PINK));     // Pinky
        ghosts.add(new Ghost(13, 14, Color.CYAN));     // Inky
        ghosts.add(new Ghost(14, 14, Color.ORANGE));   // Clyde

        pellets = new ArrayList<>();
        score = 0;
        gameInitialized = false;
        gameOver = false;
        collisionOccurred = false;

        // Get timer interval based on ghost speed setting
        int ghostSpeed = (int) GameSettings.getSetting("ghostSpeed");
        int timerDelay = 100 - (ghostSpeed - 1) * 15; // Adjust timer based on speed (85ms to 25ms)

        timer = new Timer(timerDelay, this);
        timer.start();

        addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (!gameOver) {
                    pacman.handleKeyPress(e.getKeyCode());
                }
            }
        });

        setFocusable(true);
        initializePellets();
    }

    private void initializePellets() {
        for (int row = 0; row < 28; row++) {
            for (int col = 0; col < 28; col++) {
                if (!maze.isWall(col, row)) {
                    pellets.add(new Pellet(col, row));
                }
            }
        }
        gameInitialized = true;
    }

    private boolean checkGhostCollisions() {
        int pacmanX = pacman.getX();
        int pacmanY = pacman.getY();

        for (Ghost ghost : ghosts) {
            if (ghost.getX() == pacmanX && ghost.getY() == pacmanY) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (!gameOver) {
            // Move Pacman
            pacman.move(maze);

            // Move all ghosts
            for (Ghost ghost : ghosts) {
                ghost.move(maze, pacman); // Pass pacman instance
            }

            // Check for pellet collection
            for (Pellet pellet : pellets) {
                if (pellet.isEatenBy(pacman.getX(), pacman.getY())) {
                    score += 10;
                }
            }

            // Check for ghost collisions
            if (checkGhostCollisions()) {
                if (!collisionOccurred) {
                    collisionOccurred = true;
                    repaint();
                    SwingUtilities.invokeLater(() -> {
                        try {
                            Thread.sleep(100);
                        } catch (InterruptedException ex) {
                            ex.printStackTrace();
                        }
                        gameOver();
                    });
                }
            }

            repaint();
        }
    }

    private void gameOver() {
        timer.stop();
        gameOver = true;
        JOptionPane.showMessageDialog(this,
                "Game Over!\nFinal Score: " + score,
                "Game Over",
                JOptionPane.INFORMATION_MESSAGE);
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        maze.draw(g);

        // Draw all pellets
        for (Pellet pellet : pellets) {
            pellet.draw(g);
        }

        // Draw all ghosts
        for (Ghost ghost : ghosts) {
            ghost.draw(g);
        }

        // Draw Pacman
        pacman.draw(g);

        // Draw score
        g.setColor(Color.WHITE);
        g.setFont(new Font("Arial", Font.BOLD, 16));
        g.drawString("Score: " + score, 10, 20);

        // Draw game over message if game is over
        if (gameOver) {
            g.setColor(Color.RED);
            g.setFont(new Font("Arial", Font.BOLD, 40));
            String gameOverText = "GAME OVER";
            FontMetrics fm = g.getFontMetrics();
            int textWidth = fm.stringWidth(gameOverText);
            int textHeight = fm.getHeight();
            g.drawString(gameOverText,
                    (getWidth() - textWidth) / 2,
                    (getHeight() + textHeight) / 2);
        }
    }
}