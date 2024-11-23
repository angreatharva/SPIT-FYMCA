import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;
// Use specific imports instead of java.util.*
import java.util.List;

public class Ghost {
    private int x, y;
    private int dx, dy;
    private Color color;
    private int moveCounter;
    private Random random;
    private List<int[]> currentPath;
    private static final int DIRECTION_CHANGE_INTERVAL = 20;
    private int pathIndex;

    public Ghost(int startX, int startY, Color color) {
        this.x = startX;
        this.y = startY;
        this.color = color;
        this.random = new Random();
        this.moveCounter = 0;
        this.currentPath = new ArrayList<>();
        this.pathIndex = 0;
    }

    public void draw(Graphics g) {
        g.setColor(color);
        g.fillOval(x * 20, y * 20, 20, 20);
    }

    public void move(Maze maze, Pacman pacman) {
        moveCounter++;
        boolean usePathfinding = (boolean) GameSettings.getSetting("usePathfinding");
        
        if (usePathfinding) {
            moveWithPathfinding(maze, pacman);
        } else {
            moveRandomly(maze);
        }
    }

    private void moveWithPathfinding(Maze maze, Pacman pacman) {
        if (moveCounter >= DIRECTION_CHANGE_INTERVAL || currentPath.isEmpty()) {
            currentPath = PathFinding.findShortestPath(maze, x, y, pacman.getX(), pacman.getY());
            pathIndex = 1; // Start from next position
            moveCounter = 0;
        }

        if (!currentPath.isEmpty() && pathIndex < currentPath.size()) {
            int[] nextPos = currentPath.get(pathIndex);
            x = nextPos[0];
            y = nextPos[1];
            pathIndex++;
        }
    }

    private void moveRandomly(Maze maze) {
        int newX = x + dx;
        int newY = y + dy;

        if (maze.isWall(newX, newY) || moveCounter >= DIRECTION_CHANGE_INTERVAL || random.nextDouble() < 0.1) {
            int[][] directions = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}};
            List<int[]> validDirections = new ArrayList<>();

            for (int[] dir : directions) {
                newX = x + dir[0];
                newY = y + dir[1];
                if (!maze.isWall(newX, newY)) {
                    validDirections.add(dir);
                }
            }

            if (!validDirections.isEmpty()) {
                int[] chosenDir = validDirections.get(random.nextInt(validDirections.size()));
                dx = chosenDir[0];
                dy = chosenDir[1];
                moveCounter = 0;
            }
        }

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