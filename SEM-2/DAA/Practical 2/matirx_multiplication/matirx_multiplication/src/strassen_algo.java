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

        res = strassen(mat1,mat1);

        System.out.println("Resultant Matrix: "+Arrays.deepToString(res));
    }

    static int[][] strassen(int[][] A, int[][] B) {
        int n = A.length;
        int[][] result = new int[n][n];

        int M1 = (A[0][0]+A[1][1]) * (B[0][0] + B[1][1]);
        int M2 = (A[1][0]+A[1][1]) * (B[0][0]);
        int M3 = (A[0][0]) * (B[0][1] - B[1][1]);
        int M4 = (A[1][1]) * (B[1][0] - B[0][0]);
        int M5 = (A[0][0]+A[0][1]) * (B[1][1]);
        int M6 = (A[1][0]-A[0][0]) * (B[0][0] + B[0][1]);
        int M7 = (A[0][1]-A[1][1]) * (B[1][0] + B[1][1]);

        int C11 = M1+M4-M5+M7;
        int C12 = M3+M5;
        int C21 = M2+M4;
        int C22 = M1-M2+M3+M6;

        result[0][0] = C11;
        result[0][1] = C12;
        result[1][0] = C21;
        result[1][1] = C22;

        return result;
    }
}
