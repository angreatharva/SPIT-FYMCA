import java.util.Scanner;


class BiggestOfThree {
    public void findBiggest(int num1, int num2, int num3) {
        if (num1 > num2 && num1 > num3)
            System.out.println("Num 1 is greater");
        else if (num2 > num1 && num2 > num3)
            System.out.println("Num 2 is greater");
        else
            System.out.println("Num 3 is greater");
    }
}

class Result {
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

        System.out.println("Percentage of the stundent is: " + avg);

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

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // System.out.println("Enter value of num 1: ");
        // int num1 = sc.nextInt();
        // System.out.println("Enter value of num 2: ");
        // int num2 = sc.nextInt();
        // System.out.println("Enter value of num 3: ");
        // int num3 = sc.nextInt();

        // BiggestOfThree biggest = new BiggestOfThree();
        // biggest.findBiggest(num1, num2, num3);
        
        // Result result = new Result();
        // result.calculateResult(sc);




        hourlyBasis hourlyBasisEmployee = new hourlyBasis();
        hourlyBasisEmployee.getData(1, "Atharva");
        hourlyBasisEmployee.getHourlyData(1, 800);
        hourlyBasisEmployee.calculate();
        System.out.println("Hourly Basis Employee Details:");
        hourlyBasisEmployee.putData();

        monthlyBasis monthlyBasisEmployee = new monthlyBasis();
        monthlyBasisEmployee.getData(2, "Adam");
        monthlyBasisEmployee.getMonthlyData(15000, 10,1 );
        monthlyBasisEmployee.calculate();
        System.out.println("\nMonthly Basis Employee Details:");
        monthlyBasisEmployee.putData();
    }
}
