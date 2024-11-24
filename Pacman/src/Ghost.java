import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.Random;
import java.util.List;

public class Ghost {
    private int x, y;
    private int dx, dy;
    private Color color;
    private int moveCounter;
    private Random random;
    private List<int[]> currentPath;
    private static final int DIRECTION_CHANGE_INTERVAL = 20;
    private static final int CHASE_DISTANCE = 8;
    private int pathIndex;
    private boolean isPathValid;

    public Ghost(int startX, int startY, Color color) {
        this.x = startX;
        this.y = startY;
        this.color = color;
        this.random = new Random();
        this.moveCounter = 0;
        this.currentPath = new ArrayList<>();
        this.pathIndex = 0;
        this.isPathValid = false;
    }

    public void draw(Graphics g) {
        g.setColor(color);
        g.fillOval(x * 20, y * 20, 20, 20);
    }

    public void move(Maze maze, Pacman pacman) {
        moveCounter++;
        boolean usePathfinding = (boolean) GameSettings.getSetting("usePathfinding");

        if (usePathfinding && isNearPacman(pacman)) {
            moveWithPathfinding(maze, pacman);
        } else {
            moveRandomly(maze);
            // Reset path when switching to random movement
            currentPath.clear();
            isPathValid = false;
        }
    }

    private boolean isNearPacman(Pacman pacman) {
        int distance = Math.abs(x - pacman.getX()) + Math.abs(y - pacman.getY());
        return distance <= CHASE_DISTANCE;
    }

    private void moveWithPathfinding(Maze maze, Pacman pacman) {
        // Only recalculate path if necessary
        if (shouldRecalculatePath(pacman)) {
            List<int[]> newPath = PathFinding.findShortestPath(maze, x, y, pacman.getX(), pacman.getY());

            // Validate the new path before using it
            if (isValidPath(newPath, maze)) {
                currentPath = newPath;
                pathIndex = 1; // Start from next position
                isPathValid = true;
            } else {
                // If path is invalid, fall back to random movement
                moveRandomly(maze);
                return;
            }
        }

        // Move along the current path if it's valid
        if (isPathValid && !currentPath.isEmpty() && pathIndex < currentPath.size()) {
            int[] nextPos = currentPath.get(pathIndex);

            // Validate the next position before moving
            if (isValidPosition(nextPos[0], nextPos[1], maze)) {
                x = nextPos[0];
                y = nextPos[1];
                pathIndex++;
            } else {
                // If next position is invalid, recalculate path
                currentPath.clear();
                isPathValid = false;
            }
        }
    }

    private boolean shouldRecalculatePath(Pacman pacman) {
        return moveCounter >= DIRECTION_CHANGE_INTERVAL
                || currentPath.isEmpty()
                || !isPathValid
                || pathIndex >= currentPath.size()
                || hasTargetMoved(pacman);
    }

    private boolean hasTargetMoved(Pacman pacman) {
        if (!currentPath.isEmpty()) {
            int[] target = currentPath.get(currentPath.size() - 1);
            return target[0] != pacman.getX() || target[1] != pacman.getY();
        }
        return true;
    }

    private boolean isValidPath(List<int[]> path, Maze maze) {
        if (path == null || path.isEmpty()) {
            return false;
        }

        // Check if all positions in the path are valid
        for (int[] pos : path) {
            if (!isValidPosition(pos[0], pos[1], maze)) {
                return false;
            }
        }

        // Check if the path starts near current position
        int[] firstPos = path.get(0);
        int distanceToStart = Math.abs(x - firstPos[0]) + Math.abs(y - firstPos[1]);
        return distanceToStart <= 1;
    }

    private boolean isValidPosition(int newX, int newY, Maze maze) {
        // Check if position is within maze bounds and not a wall
        if (newX < 0 || newY < 0 || newX >= 28 || newY >= 28) {
            return false;
        }
        return !maze.isWall(newX, newY);
    }

    private void moveRandomly(Maze maze) {
        if (maze.isWall(x + dx, y + dy) || moveCounter >= DIRECTION_CHANGE_INTERVAL || random.nextDouble() < 0.2) {
            int[][] directions = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}};
            List<int[]> validDirections = new ArrayList<>();

            for (int[] dir : directions) {
                int newX = x + dir[0];
                int newY = y + dir[1];
                if (isValidPosition(newX, newY, maze)) {
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

        // Only move if the new position is valid
        int newX = x + dx;
        int newY = y + dy;
        if (isValidPosition(newX, newY, maze)) {
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