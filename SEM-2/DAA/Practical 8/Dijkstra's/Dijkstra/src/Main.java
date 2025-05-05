import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Input number of vertices and edges
        System.out.print("Enter number of vertices: ");
        int v = scanner.nextInt();
        System.out.print("Enter number of edges: ");
        int e = scanner.nextInt();

        List<List<DijkstraAlgorithm.Edge>> graph = new ArrayList<>();
        for (int i = 0; i < v; i++) graph.add(new ArrayList<>());

        // Input edges
        System.out.println("Enter edges in format: source target weight");
        int lastTarget = -1;
        for (int i = 0; i < e; i++) {
            int src = scanner.nextInt();
            int tgt = scanner.nextInt();
            int wgt = scanner.nextInt();
            graph.get(src).add(new DijkstraAlgorithm.Edge(tgt, wgt));
            lastTarget = tgt; // Keep updating to get the last entered vertex
        }

        // Input source vertex
        System.out.print("Enter source vertex: ");
        int source = scanner.nextInt();

        System.out.println();
        DijkstraAlgorithm.dijkstra(graph, source, lastTarget);

        scanner.close();
    }
}

//Enter number of vertices: 6
//Enter number of edges: 8
//Enter edges in format: source target weight
//0 2 4
//0 1 4
//1 2 2
//2 3 3
//2 5 6
//2 4 1
//3 5 2
//4 5 3
//Enter source vertex: 0