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
        for (int i = 0; i < e; i++) {
            int src = scanner.nextInt();
            int tgt = scanner.nextInt();
            int wgt = scanner.nextInt();
            graph.get(src).add(new DijkstraAlgorithm.Edge(tgt, wgt));
            // If undirected graph, also add the reverse edge
            // graph.get(tgt).add(new Edge(src, wgt));
        }

        // Input source vertex
        System.out.print("Enter source vertex: ");
        int source = scanner.nextInt();

        DijkstraAlgorithm.dijkstra(graph, source);

        scanner.close();
    }
}

//Enter number of vertices: 5
//Enter number of edges: 6
//Enter edges in format: source target weight
//0 1 4
//        0 2 1
//        2 1 2
//        1 3 1
//        2 3 5
//        3 4 3
//Enter source vertex: 0