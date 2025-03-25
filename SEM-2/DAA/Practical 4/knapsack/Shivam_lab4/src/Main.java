import java.util.Scanner;

public class Main {
    // Function to solve 0/1 Knapsack using Dynamic Programming
    public static int knapsack(int W, int wt[], int val[], int n) {
        int dp[][] = new int[n + 1][W + 1];

        // Build the DP table in bottom-up manner
        for (int i = 0; i <= n; i++) {
            for (int w = 0; w <= W; w++) {
                if (i == 0 || w == 0) {
                    dp[i][w] = 0; // Base case
                } else if (wt[i - 1] <= w) {
                    // Either include the item or exclude it
                    dp[i][w] = Math.max(val[i - 1] + dp[i - 1][w - wt[i - 1]], dp[i - 1][w]);
                } else {
                    // If weight exceeds capacity, exclude the item
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }
        return dp[n][W]; // Maximum profit
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Input: Number of items
        System.out.print("Enter the number of items: ");
        int n = sc.nextInt();

        int val[] = new int[n];
        int wt[] = new int[n];

        // Input: Profit and Weight for each item
        System.out.println("Enter the profit and weight of each item:");
        for (int i = 0; i < n; i++) {
            System.out.print("Item " + (i + 1) + " - Profit: ");
            val[i] = sc.nextInt();
            System.out.print("Item " + (i + 1) + " - Weight: ");
            wt[i] = sc.nextInt();
        }

        // Input: Maximum weight capacity of knapsack
        System.out.print("Enter the maximum weight capacity of the knapsack: ");
        int W = sc.nextInt();

        // Compute the maximum profit
        int maxProfit = knapsack(W, wt, val, n);
        System.out.println("Maximum profit that can be obtained: " + maxProfit);

        sc.close();
    }
}
