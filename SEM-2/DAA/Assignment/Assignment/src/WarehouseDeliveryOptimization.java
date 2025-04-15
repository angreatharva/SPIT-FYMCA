// WarehouseDeliveryOptimization.java
// This program demonstrates various Design and Analysis of Algorithms (DAA)
// concepts applied to a warehouse delivery optimization problem.

import java.util.Arrays;

public class WarehouseDeliveryOptimization {

    // Package class represents items that can be delivered
    // Each package has weight, value, urgency, and a calculated priority
    static class Package implements Comparable<Package> {
        int weight;      // How heavy the package is
        int value;       // How much the package is worth
        int urgency;     // How urgent the delivery is (higher = more urgent)
        double priority; // Combined measure of package importance

        public Package(int weight, int value, int urgency) {
            this.weight = weight;
            this.value = value;
            this.urgency = urgency;
            // Priority formula: value-to-weight ratio plus urgency
            this.priority = ((double) value / weight) + urgency;
        }

        // Compare packages by priority (higher priority comes first)
        @Override
        public int compareTo(Package other) {
            return Double.compare(other.priority, this.priority);
        }

        @Override
        public String toString() {
            return "Package(weight=" + weight + ", value=" + value + ", urgency=" + urgency
                    + ", priority=" + String.format("%.2f", priority) + ")";
        }
    }

    // Create a result container class for Matrix Chain Multiplication
    static class MatrixChainResult {
        int[][] costTable;    // DP table with minimum costs
        int[][] splitTable;   // Table with optimal split points

        public MatrixChainResult(int[][] costTable, int[][] splitTable) {
            this.costTable = costTable;
            this.splitTable = splitTable;
        }
    }

    // 1. Binary Search - Find the longest route that doesn't exceed time limit
    public static int binarySearchLongestRoute(int[] routeTimes, int maxTime) {
        int[] arr = routeTimes;
        Arrays.sort(arr);  // Sort routes by time
        int left = 0;
        int right = arr.length - 1;
        int result = -1;   // Default if no valid route found

        // Binary search to find longest route within time limit
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] <= maxTime) {
                // This route works, save it and look for longer ones
                result = arr[mid];
                left = mid + 1;
            } else {
                // This route is too long, look for shorter ones
                right = mid - 1;
            }
        }
        return result;
    }

    // 2. Merge Sort - Sort packages by priority
    public static void mergeSort(Package[] arr, int left, int right) {
        // Base case: if the array has more than one element
        if (left < right) {
            // Find middle point
            int mid = left + (right - left) / 2;

            // Sort first and second halves
            mergeSort(arr, left, mid);
            mergeSort(arr, mid + 1, right);

            // Merge the sorted halves
            merge(arr, left, mid, right);
        }
    }

    // Helper method to merge two sorted subarrays
    public static void merge(Package[] arr, int left, int mid, int right) {
        // Create temporary arrays
        int n1 = mid - left + 1;  // Size of left subarray
        int n2 = right - mid;     // Size of right subarray
        Package[] leftArr = new Package[n1];
        Package[] rightArr = new Package[n2];

        // Copy data to temporary arrays
        for (int i = 0; i < n1; i++) {
            leftArr[i] = arr[left + i];
        }
        for (int j = 0; j < n2; j++) {
            rightArr[j] = arr[mid + 1 + j];
        }

        // Merge the temporary arrays back into the original array
        int i = 0, j = 0, k = left;
        while (i < n1 && j < n2) {
            // Use compareTo to sort by priority (descending)
            if (leftArr[i].compareTo(rightArr[j]) <= 0) {
                arr[k++] = leftArr[i++];
            } else {
                arr[k++] = rightArr[j++];
            }
        }

        // Copy remaining elements if any
        while (i < n1) {
            arr[k++] = leftArr[i++];
        }
        while (j < n2) {
            arr[k++] = rightArr[j++];
        }
    }

    // 3. 0/1 Knapsack - Find best combination of whole packages within weight limit
    public static int knapSack01(Package[] packages, int maxWeight) {
        int n = packages.length;
        // DP table: rows=packages, columns=weights
        int[][] dp = new int[n + 1][maxWeight + 1];

        // Fill DP table bottom-up
        for (int i = 1; i <= n; i++) {
            int weight = packages[i - 1].weight;
            int value = packages[i - 1].value;

            for (int w = 0; w <= maxWeight; w++) {
                if (weight <= w) {
                    // Choose maximum of: (1) skip this package or (2) take this package
                    dp[i][w] = Math.max(dp[i - 1][w], dp[i - 1][w - weight] + value);
                } else {
                    // Can't take this package, too heavy
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }
        // Return maximum possible value
        return dp[n][maxWeight];
    }

    // 4. Fractional Knapsack - Allow partial packages to maximize value
    public static double fractionalKnapSack(Package[] packages, int maxWeight) {
        // Make a copy to avoid changing original array
        Package[] arr = packages.clone();

        // Sort by value/weight ratio (best value per weight first)
        Arrays.sort(arr, (a, b) -> {
            double ratioA = (double) a.value / a.weight;
            double ratioB = (double) b.value / b.weight;
            return Double.compare(ratioB, ratioA);
        });

        double totalValue = 0.0;
        int remainingWeight = maxWeight;

        // Take packages in order of best value/weight
        for (Package p : arr) {
            if (remainingWeight == 0)
                break;

            if (p.weight <= remainingWeight) {
                // Take the whole package
                totalValue += p.value;
                remainingWeight -= p.weight;
            } else {
                // Take a fraction of the package
                double fraction = (double) remainingWeight / p.weight;
                totalValue += p.value * fraction;
                remainingWeight = 0;
            }
        }
        return totalValue;
    }

    // 5. Strassen's Matrix Multiplication for 2x2 matrices
    // Uses 7 multiplications instead of 8 required by standard method
    public static int[][] strassenMultiply(int[][] A, int[][] B) {
        // Extract matrix elements
        int a = A[0][0];
        int b = A[0][1];
        int c = A[1][0];
        int d = A[1][1];

        int e = B[0][0];
        int f = B[0][1];
        int g = B[1][0];
        int h = B[1][1];

        // Calculate the 7 products (these replace 8 multiplications)
        int m1 = (a + d) * (e + h);
        int m2 = (c + d) * e;
        int m3 = a * (f - h);
        int m4 = d * (g - e);
        int m5 = (a + b) * h;
        int m6 = (c - a) * (e + f);
        int m7 = (b - d) * (g + h);

        // Calculate final matrix values from the products
        int[][] C = new int[2][2];
        C[0][0] = m1 + m4 - m5 + m7;
        C[0][1] = m3 + m5;
        C[1][0] = m2 + m4;
        C[1][1] = m1 - m2 + m3 + m6;

        return C;
    }

    // 6. Matrix Chain Multiplication - Find optimal way to multiply matrices
    // The dims array represents matrix dimensions: matrix i has size dims[i-1] x dims[i]
    public static MatrixChainResult matrixChainOrder(int[] dims) {
        int n = dims.length - 1; // Number of matrices

        // DP table for minimum costs
        int[][] dp = new int[n + 1][n + 1];

        // Table to store the splitting point k for each subproblem (i,j)
        int[][] split = new int[n + 1][n + 1];

        // Initialize: cost of multiplying one matrix is 0
        for (int i = 1; i <= n; i++) {
            dp[i][i] = 0;
        }

        // L is chain length (number of matrices in the subproblem)
        for (int L = 2; L <= n; L++) {
            for (int i = 1; i <= n - L + 1; i++) {
                int j = i + L - 1;
                dp[i][j] = Integer.MAX_VALUE;

                // Try each split point k between i and j
                for (int k = i; k < j; k++) {
                    // Calculate cost for this split
                    int cost = dp[i][k] + dp[k + 1][j] + dims[i - 1] * dims[k] * dims[j];

                    // Update if this is better than previous
                    if (cost < dp[i][j]) {
                        dp[i][j] = cost;
                        split[i][j] = k;  // Remember the best split point
                    }
                }
            }
        }

        // Return both tables together in a result object
        return new MatrixChainResult(dp, split);
    }

    // Print optimal parenthesization showing how to multiply matrices
    public static void printOptimalParens(int[][] split, int i, int j) {
        if (i == j) {
            // Base case: single matrix
            System.out.print("A" + i);
        } else {
            // Recursive case: multiply two subproblems
            System.out.print("(");
            printOptimalParens(split, i, split[i][j]);
            printOptimalParens(split, split[i][j] + 1, j);
            System.out.print(")");
        }
    }

    // Print the DP table showing minimum cost for each subproblem
    public static void printDPTable(int[][] dp, int n) {
        System.out.println("DP Table (Minimum Cost of Multiplications):");
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < n; j++) {
                if (i > j) {
                    System.out.print("\t");  // Empty cell
                } else {
                    System.out.print(dp[i][j] + "\t");
                }
            }
            System.out.println();
        }
    }

    // Print the split table showing best split point for each subproblem
    public static void printSplitTable(int[][] split, int n) {
        System.out.println("Split Table (Best split points k):");
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < n; j++) {
                if (i >= j) {
                    System.out.print("\t");  // Empty cell
                } else {
                    System.out.print(split[i][j] + "\t");
                }
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        // Input Data
        int[] route_times = {2, 4, 6, 8, 10}; // in hours
        int truck_max_time = 7;
        int truck_max_weight = 5;

        // Packages: each defined as (weight, value, urgency)
        Package[] packages = {
                new Package(2, 40, 3),
                new Package(3, 50, 2),
                new Package(4, 60, 1)
        };

        // Route cost matrices (2x2 each)
        int[][] A = {
                {1, 2},
                {3, 4}
        };
        int[][] B = {
                {5, 6},
                {7, 8}
        };

        // Matrix chain multiplication dimensions for three matrices:
        // Matrix A1: 10x20, A2: 20x30, A3: 30x40.
        // The dims array is {10, 20, 30, 40}.
        int[] dims = {10, 20, 30, 40};

        // -------------------------------
        // 1. Binary Search: Route Selection
        int longestRoute = binarySearchLongestRoute(route_times, truck_max_time);
        System.out.println("Longest route time <= " + truck_max_time + ": " + longestRoute);

        // -------------------------------
        // 2. Sorting: Package Priority using Merge Sort
        Package[] packagesForSort = packages.clone(); // Create a copy to sort
        mergeSort(packagesForSort, 0, packagesForSort.length - 1);
        System.out.println("\nSorted packages by priority (descending):");
        for (Package p : packagesForSort) {
            System.out.println(p);
        }

        // -------------------------------
        // 3. 0/1 Knapsack: Selecting whole packages to maximize value within weight limit
        int maxValue01 = knapSack01(packages, truck_max_weight);
        System.out.println("\nMaximum value (0/1 Knapsack): " + maxValue01);

        // -------------------------------
        // 4. Fractional Knapsack: Using greedy algorithm to choose fractions of packages
        double maxValueFractional = fractionalKnapSack(packages, truck_max_weight);
        System.out.println("Maximum value (Fractional Knapsack): " + maxValueFractional);

        // -------------------------------
        // 5. Strassen's Matrix Multiplication: Multiplying matrices A and B
        int[][] strassenResult = strassenMultiply(A, B);
        System.out.println("\nResultant matrix from Strassen's multiplication:");
        for (int i = 0; i < strassenResult.length; i++) {
            for (int j = 0; j < strassenResult[0].length; j++) {
                System.out.print(strassenResult[i][j] + " ");
            }
            System.out.println();
        }

        // -------------------------------
        // 6. Matrix Chain Multiplication: Compute minimum multiplication cost
        MatrixChainResult mcResult = matrixChainOrder(dims);
        int[][] dp = mcResult.costTable;
        int[][] split = mcResult.splitTable;
        int n = dims.length;

        System.out.println("\nMinimum cost of multiplying the matrix chain: " + dp[1][n-1]);

        // Print optimal parenthesization
        System.out.print("\nOptimal Parenthesization: ");
        printOptimalParens(split, 1, n-1);
        System.out.println();

        // Print DP and Split tables
        System.out.println();
        printDPTable(dp, n);
        System.out.println();
        printSplitTable(split, n);
    }
}