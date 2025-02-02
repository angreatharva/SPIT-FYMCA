import java.util.Scanner;

public class Result {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("\n*Result*");
        Result result = new Result();
        result.calculateResult(sc);
    }
        public void calculateResult(Scanner sc) {
            System.out.println("\nEnter the Marks of the subject");

            System.out.println("Enter the Marks of DAA subject: ");
            int DAA = sc.nextInt();

            System.out.println("Enter the Marks of DevOps subject: ");
            int DevOps = sc.nextInt();

            System.out.println("Enter the Marks of AJP subject: ");
            int AJP = sc.nextInt();

            System.out.println("Enter the Marks of MP subject: ");
            int MP = sc.nextInt();

            System.out.println("Enter the Marks of PA subject: ");
            int PA = sc.nextInt();

            System.out.println("Enter the Marks of PCS subject: ");
            int PCS = sc.nextInt();

            System.out.println("Enter the Marks of PNS subject: ");
            int PNS = sc.nextInt();

            int avg = (DAA + DevOps + AJP + MP + PA + PCS + PNS) / 7;

            System.out.println("Percentage of the student is: " + avg);

            if (avg >= 90)
                System.out.println("The Student got Grade A+");
            else if (avg >= 80)
                System.out.println("The Student got Grade A");
            else if (avg >= 70)
                System.out.println("The Student got Grade B+");
            else if (avg >= 60)
                System.out.println("The Student got Grade B");
            else if (avg >= 50)
                System.out.println("The Student got Grade C");
            else if (avg >= 35)
                System.out.println("The Student got Grade D");
            else
                System.out.println("The Student got Grade F");
        }


}
