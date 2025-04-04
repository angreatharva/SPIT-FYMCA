public class zerobyoneknapsack {
    public static void main(String[] args) {
        int[] weights = {2,3,5};
        int[] profits = {10,15,20};
        int capacity = 7;
        int n = weights.length;

        int maxProfit = knapsack(n, capacity, weights, profits);
        System.out.println("Maximum Profit: " + maxProfit);
    }

    public static int knapsack(int n, int capacity, int[] weights, int[] profits) {
        int[][] dp = new int[n + 1][capacity + 1];

        for (int i = 1; i <= n; i++) {
            for (int w = 0; w <= capacity; w++) {
                if (weights[i - 1] <= w) {
                    dp[i][w] = Math.max(dp[i - 1][w], profits[i - 1] + dp[i - 1][w - weights[i - 1]]);
                } else {
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }
        return dp[n][capacity];
    }
}
