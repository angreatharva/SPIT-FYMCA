import java.util.*;

public class DijkstraAlgorithm {

    static class Edge {
        int target, weight;
        Edge(int target, int weight) {
            this.target = target;
            this.weight = weight;
        }
    }

    public static void dijkstra(List<List<Edge>> graph, int source) {
        int n = graph.size();
        int[] distance = new int[n];
        boolean[] visited = new boolean[n];

        Arrays.fill(distance, Integer.MAX_VALUE);
        distance[source] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[] {source, 0});

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0];

            if (visited[node]) continue;
            visited[node] = true;

            for (Edge edge : graph.get(node)) {
                if (distance[edge.target] > distance[node] + edge.weight) {
                    distance[edge.target] = distance[node] + edge.weight;
                    pq.offer(new int[] {edge.target, distance[edge.target]});
                }
            }
        }

        // Print shortest distances
        System.out.println("\nShortest distances from source " + source + ":");
        for (int i = 0; i < n; i++) {
            System.out.println("To vertex " + i + " --> " + (distance[i] == Integer.MAX_VALUE ? "Unreachable" : distance[i]));
        }
    }

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
