import java.util.Arrays;
import java.util.Scanner;

public class strassen_algo {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int r1=0,r2=0;
        int c1=0,c2=0;
        int num=0;

        System.out.print("Enter the Value of num of Rows in Matrix1: ");
        r1 = sc.nextInt();
        System.out.print("Enter the Value of num of Columns in Matrix1: ");
        c1 = sc.nextInt();

        System.out.print("Enter the Value of num of Rows in Matrix2: ");
        r2 = sc.nextInt();
        System.out.print("Enter the Value of num of Columns in Matrix2: ");
        c2 = sc.nextInt();

        if (c1 != r2) {
            System.out.println("Matrix multiplication is not possible. Number of " +
                    "columns in Matrix1 must equal the number of rows in Matrix2.");
            return;
        }

        int[][] mat1 = new int[r1][c1];
        int[][] mat2 = new int[r2][c2];
        int[][] res = new int[r1][c2];

        for (int i =0; i < r1; i++){
            for(int j=0; j < c1; j++){
                System.out.print("Enter the Value for Mat1: ");
                num = sc.nextInt();
                mat1[i][j] = num;
            }
        }
        for (int i =0; i < r2; i++){
            for(int j=0; j < c2; j++){
                System.out.print("Enter the Value for Mat2: ");
                num = sc.nextInt();
                mat2[i][j] = num;
            }
        }

        System.out.println("Matrix 1: "+ Arrays.deepToString(mat1));
        System.out.println("Matrix 2: "+Arrays.deepToString(mat2));

        res = strassen(mat1,mat2);

        System.out.println("Resultant Matrix: "+Arrays.deepToString(res));
    }

    static int[][] strassen(int[][] A, int[][] B) {
        int n = A.length;
        int[][] result = new int[n][n];

        if (n == 1) {
            result[0][0] = A[0][0] * B[0][0];
            return result;
        }
        int newSize = n / 2;
        int[][] A11 = new int[newSize][newSize];
        int[][] A12 = new int[newSize][newSize];
        int[][] A21 = new int[newSize][newSize];
        int[][] A22 = new int[newSize][newSize];
        int[][] B11 = new int[newSize][newSize];
        int[][] B12 = new int[newSize][newSize];
        int[][] B21 = new int[newSize][newSize];
        int[][] B22 = new int[newSize][newSize];

        for (int i = 0; i < newSize; i++) {
            for (int j = 0; j < newSize; j++) {
                A11[i][j] = A[i][j];
                A12[i][j] = A[i][j + newSize];
                A21[i][j] = A[i + newSize][j];
                A22[i][j] = A[i + newSize][j + newSize];
                B11[i][j] = B[i][j];
                B12[i][j] = B[i][j + newSize];
                B21[i][j] = B[i + newSize][j];
                B22[i][j] = B[i + newSize][j + newSize];
            }
        }

        int[][] P1 = strassen(add(A11, A22), add(B11, B22));
        int[][] P2 = strassen(add(A21, A22), B11);
        int[][] P3 = strassen(A11, subtract(B12, B22));
        int[][] P4 = strassen(A22, subtract(B21, B11));
        int[][] P5 = strassen(add(A11, A12), B22);
        int[][] P6 = strassen(subtract(A21, A11), add(B11, B12));
        int[][] P7 = strassen(subtract(A12, A22), add(B21, B22));

        int[][] C11 = add(subtract(add(P1, P4), P5), P7);
        int[][] C12 = add(P3, P5);
        int[][] C21 = add(P2, P4);
        int[][] C22 = add(subtract(add(P1, P3), P2), P6);

        for (int i = 0; i < newSize; i++) {
            for (int j = 0; j < newSize; j++) {
                result[i][j] = C11[i][j];
                result[i][j + newSize] = C12[i][j];
                result[i + newSize][j] = C21[i][j];
                result[i + newSize][j + newSize] = C22[i][j];
            }
        }

        return result;
    }

    static int[][] add(int[][] A, int[][] B) {
        int n = A.length;
        int[][] result = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = A[i][j] + B[i][j];
            }
        }
        return result;
    }

    static int[][] subtract(int[][] A, int[][] B) {
        int n = A.length;
        int[][] result = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = A[i][j] - B[i][j];
            }
        }
        return result;
    }
}
