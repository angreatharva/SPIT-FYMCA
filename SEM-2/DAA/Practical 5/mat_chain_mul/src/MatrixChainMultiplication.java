import java.util.Scanner;

public class MatrixChainMultiplication {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the number of matrices: ");
        int numMatrices = sc.nextInt();

        int[] dimensions = new int[numMatrices + 1];

        System.out.println("Enter the array of dimensions (space-separated): ");
        for (int i = 0; i <= numMatrices; i++) {
            dimensions[i] = sc.nextInt();
        }

        System.out.println("\nMatrix dimensions:");
        for (int i = 1; i <= numMatrices; i++) {
            System.out.println("A" + i + " : " + dimensions[i - 1] + " x " + dimensions[i]);
        }

        matrixChainOrder(dimensions, numMatrices + 1);
        sc.close();
    }

    static void matrixChainOrder(int[] p, int n) {
        int[][] m = new int[n][n];
        int[][] s = new int[n][n];

        for (int L = 2; L < n; L++) {
            for (int i = 1; i < n - L + 1; i++) {
                int j = i + L - 1;
                m[i][j] = Integer.MAX_VALUE;
                for (int k = i; k < j; k++) {
                    int q = m[i][k] + m[k + 1][j] + p[i - 1] * p[k] * p[j];
                    if (q < m[i][j]) {
                        m[i][j] = q;
                        s[i][j] = k;
                    }
                }
            }
        }

        System.out.print("\nOptimal Parenthesis: ");
        printOptimalParens(s, 1, n - 1);
        System.out.println("\n\nMinimum Cost of Multiplications: " + m[1][n - 1]);

        System.out.println("\nDP Table (Minimum Cost of Multiplications):");
        printDPTable(m, n);

        System.out.println("\nSplit Table:");
        printSplitTable(s, n);
    }

    static void printOptimalParens(int[][] s, int i, int j) {
        if (i == j) {
            System.out.print("A" + i);
        } else {
            System.out.print("(");
            printOptimalParens(s, i, s[i][j]);
            printOptimalParens(s, s[i][j] + 1, j);
            System.out.print(")");
        }
    }

    static void printDPTable(int[][] m, int n) {
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < n; j++) {
                if (i > j) System.out.print("\t");
                else System.out.print(m[i][j] + "\t");
            }
            System.out.println();
        }
    }

    static void printSplitTable(int[][] s, int n) {
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < n; j++) {
                if (i >= j) System.out.print("\t");
                else System.out.print(s[i][j] + "\t");
            }
            System.out.println();
        }
    }
}
