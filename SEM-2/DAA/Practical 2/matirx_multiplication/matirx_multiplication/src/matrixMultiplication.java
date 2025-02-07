import java.util.Arrays;
import java.util.Scanner;

public class matrixMultiplication {
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

        System.out.println("Matrix 1: "+Arrays.deepToString(mat1));
        System.out.println("Matrix 2: "+Arrays.deepToString(mat2));

        mulMat(mat1,mat2,res);

        System.out.println("Resultant Matrix: "+Arrays.deepToString(res));
    }

    static void mulMat(int[][] m1, int[][] m2, int[][] res) {
        int r1 = m1.length;
        int c1 = m1[0].length;
        int c2 = m2[0].length;

        for (int i = 0; i < r1; i++) {
            for (int j = 0; j < c2; j++) {
                res[i][j] = 0;
                for (int k = 0; k < c1; k++) {
                    res[i][j] += m1[i][k] * m2[k][j];
                }
            }
        }
    }
}

