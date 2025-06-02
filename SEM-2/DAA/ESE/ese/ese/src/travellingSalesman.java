import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class travellingSalesman {
    public static int n;
    public static int[][] cost;
    public static boolean[] visited;
    public static int[] bestTour;
    public static int bestCost = Integer.MAX_VALUE;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter the number of cities: ");
        n = sc.nextInt();
        cost = new int[n][n];
        System.out.println("Enter cost matrix (" + n + "x" + n + "):");
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                cost[i][j] = sc.nextInt();
        visited = new boolean[n];
        bestTour = new int[n + 1];
        solve();
        printResult();
    }

    public static void solve() {
        visited[0] = true;
        ArrayList<Integer> path = new ArrayList<>();
        path.add(0);
        branchAndBound(0, 1, 0, path);
    }

    private static void branchAndBound(int currentCity, int level, int currentCost, List<Integer> path) {
        if (level == n) {
            int totalCost = currentCost + cost[currentCity][0];
            if (totalCost < bestCost) {
                bestCost = totalCost;
                for (int i = 0; i < n; i++)
                    bestTour[i] = path.get(i);
                bestTour[n] = 0;
            }
            return;
        }
        for (int next = 0; next < n; next++) {
            if (!visited[next]) {
                int tempCost = currentCost + cost[currentCity][next];
                if (tempCost < bestCost) {
                    visited[next] = true;
                    path.add(next);
                    branchAndBound(next, level + 1, tempCost, path);
                    path.remove(path.size() - 1);
                    visited[next] = false;
                }
            }
        }
    }
    public static void printResult() {
        System.out.println("Optimal tour cost: " + bestCost);
        System.out.print("Tour path: ");
        for (int city : bestTour) System.out.print(city + " ");
        System.out.println();
    }

}
