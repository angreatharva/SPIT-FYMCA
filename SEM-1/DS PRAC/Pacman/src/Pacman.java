import java.awt.*;
import java.awt.event.KeyEvent;

public class Pacman {
    private int x, y;
    private int dx, dy;

    public Pacman(int startX, int startY) {
        this.x = startX;
        this.y = startY;
        this.dx = 0;
        this.dy = 0;
    }

    public void draw(Graphics g) {
        g.setColor(Color.YELLOW);
        g.fillOval(x * 20 + 2, y * 20 + 2, 16, 16); // Adjust for grid size
    }

    public void move(Maze maze) {
        int newX = x + dx;
        int newY = y + dy;

        if (!maze.isWall(newX, newY)) { // Move only if no wall
            x = newX;
            y = newY;
        }
    }

    public void handleKeyPress(int keyCode) {
        switch (keyCode) {
            case KeyEvent.VK_UP -> { dx = 0; dy = -1; }
            case KeyEvent.VK_DOWN -> { dx = 0; dy = 1; }
            case KeyEvent.VK_LEFT -> { dx = -1; dy = 0; }
            case KeyEvent.VK_RIGHT -> { dx = 1; dy = 0; }
        }
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}
