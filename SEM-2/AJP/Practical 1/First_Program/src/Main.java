import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Biggest of Three
        System.out.println("\n*Biggest of Three*");
        System.out.println("Enter value of num 1: ");
        int num1 = sc.nextInt();
        System.out.println("Enter value of num 2: ");
        int num2 = sc.nextInt();
        System.out.println("Enter value of num 3: ");
        int num3 = sc.nextInt();

        BiggestOfThree biggest = new BiggestOfThree();
        biggest.findBiggest(num1, num2, num3);

        // Result
        System.out.println("\n*Result*");
        Result result = new Result();
        result.calculateResult(sc);

        // Calculator
        System.out.println("\n*Calculator*");
        Calculator.performCalculator(sc);

        // Hourly Basis Employee
        System.out.println("\n*Hourly Basis Employee*");
        hourlyBasis hourlyBasisEmployee = new hourlyBasis();
        hourlyBasisEmployee.getData(1, "Atharva");
        hourlyBasisEmployee.getHourlyData(1, 800);
        hourlyBasisEmployee.calculate();
        System.out.println("Hourly Basis Employee Details:");
        hourlyBasisEmployee.putData();

        // Monthly Basis Employee
        System.out.println("\n*Monthly Basis Employee*");
        monthlyBasis monthlyBasisEmployee = new monthlyBasis();
        monthlyBasisEmployee.getData(2, "Adam");
        monthlyBasisEmployee.getMonthlyData(15000, 10, 1);
        monthlyBasisEmployee.calculate();
        System.out.println("\nMonthly Basis Employee Details:");
        monthlyBasisEmployee.putData();
    }
}
