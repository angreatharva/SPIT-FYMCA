import java.util.Scanner;

public class BiggestOfThree {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);


        System.out.println("\n*Biggest of Three*");
        System.out.println("Enter value of num 1: ");
        int num1 = sc.nextInt();
        System.out.println("Enter value of num 2: ");
        int num2 = sc.nextInt();
        System.out.println("Enter value of num 3: ");
        int num3 = sc.nextInt();

        BiggestOfThree biggest = new BiggestOfThree();
        biggest.findBiggest(num1, num2, num3);
    }
        public void findBiggest(int num1, int num2, int num3) {
            if (num1 > num2 && num1 > num3)
                System.out.println("Num 1 is greater");
            else if (num2 > num1 && num2 > num3)
                System.out.println("Num 2 is greater");
            else
                System.out.println("Num 3 is greater");
        }

}
