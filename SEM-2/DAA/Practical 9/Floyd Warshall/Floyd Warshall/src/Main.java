import java.util.Scanner;

public class Main {
    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter number of vertices: ");
        int V = sc.nextInt();

        int[][] graph = new int[V][V];

        System.out.println("Enter the adjacency matrix (use " + FloydWarshall.INF + " for no direct edge):");
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                graph[i][j] = sc.nextInt();
            }
        }

        FloydWarshall.floydWarshall(graph, V);
        sc.close();
    }
}

//Enter number of vertices: 4
//Enter the adjacency matrix (use 99999 for no direct edge):
//        0 3 99999 7
//        8 0 2 99999
//        5 99999 0 1
//        2 99999 99999 0
//All Pairs Shortest Distances:
//        0   3   5   6
//        5   0   2   3
//        3   6   0   1
//        2   5   7   0
