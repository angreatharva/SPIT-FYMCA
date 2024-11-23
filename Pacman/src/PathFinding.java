// File: Pathfinding.java
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

public class PathFinding {
    private static final int[] DX = {0, 1, 0, -1}; // Right, Down, Left, Up
    private static final int[] DY = {1, 0, -1, 0};

    public static List<int[]> findShortestPath(Maze maze, int startX, int startY, int targetX, int targetY) {
        int rows = 28; // Maze dimensions
        int cols = 28;
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> queue = new LinkedList<>();
        Map<String, int[]> parentMap = new HashMap<>();
        
        int[] start = {startX, startY};
        queue.add(start);
        visited[startY][startX] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            
            if (current[0] == targetX && current[1] == targetY) {
                return reconstructPath(parentMap, start, new int[]{targetX, targetY});
            }

            for (int i = 0; i < 4; i++) {
                int nx = current[0] + DX[i];
                int ny = current[1] + DY[i];

                if (isValid(nx, ny, maze, visited)) {
                    int[] next = {nx, ny};
                    queue.add(next);
                    visited[ny][nx] = true;
                    parentMap.put(nx + "," + ny, current);
                }
            }
        }
        return new ArrayList<>();
    }

    private static boolean isValid(int x, int y, Maze maze, boolean[][] visited) {
        return x >= 0 && x < 28 && y >= 0 && y < 28 && !maze.isWall(x, y) && !visited[y][x];
    }

    private static List<int[]> reconstructPath(Map<String, int[]> parentMap, int[] start, int[] target) {
        List<int[]> path = new ArrayList<>();
        int[] current = target;
        
        while (current != null && (current[0] != start[0] || current[1] != start[1])) {
            path.add(current);
            current = parentMap.get(current[0] + "," + current[1]);
        }
        path.add(start);
        Collections.reverse(path);
        return path;
    }
}