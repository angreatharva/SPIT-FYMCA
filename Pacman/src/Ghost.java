import java.awt.*;
import java.util.Random;

public class Ghost {
    private int x, y;
    private int dx, dy;
    private Random random;
    private Color color;
    private int moveCounter;
    private static final int DIRECTION_CHANGE_INTERVAL = 20;

    public Ghost(int startX, int startY, Color color) {
        this.x = startX;
        this.y = startY;
        this.dx = 0;
        this.dy = 0;
        this.random = new Random();
        this.color = color;
        this.moveCounter = 0;
    }

    public void draw(Graphics g) {
        g.setColor(color);
        // Draw ghost body
        g.fillOval(x * 20, y * 20, 20, 20);
    }

    public void move(Maze maze) {
        moveCounter++;

        // Try to move in the current direction first
        int newX = x + dx;
        int newY = y + dy;

        // Change direction periodically or when blocked
        if (maze.isWall(newX, newY) || moveCounter >= DIRECTION_CHANGE_INTERVAL || random.nextDouble() < 0.1) {
            // Get all possible directions
            int[][] directions = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}};
            java.util.List<int[]> validDirections = new java.util.ArrayList<>();

            // Check which directions are valid (not walls)
            for (int[] dir : directions) {
                newX = x + dir[0];
                newY = y + dir[1];
                if (!maze.isWall(newX, newY)) {
                    validDirections.add(dir);
                }
            }

            // Choose a random valid direction
            if (!validDirections.isEmpty()) {
                int[] chosenDir = validDirections.get(random.nextInt(validDirections.size()));
                dx = chosenDir[0];
                dy = chosenDir[1];
                moveCounter = 0;
            }
        }

        // Move if the new position is valid
        newX = x + dx;
        newY = y + dy;
        if (!maze.isWall(newX, newY)) {
            x = newX;
            y = newY;
        }
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}