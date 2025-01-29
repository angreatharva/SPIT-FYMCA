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

class Calculator {

    public static void performCalculator(Scanner sc) {
        int num1, num2, choice;

        System.out.println("Enter the value for 1st Number: ");
        num1 = sc.nextInt();

        System.out.println("Enter the value for 2nd Number: ");
        num2 = sc.nextInt();

        do {
            System.out.println("\nMenu:");
            System.out.println("1. Addition");
            System.out.println("2. Subtraction");
            System.out.println("3. Multiplication");
            System.out.println("4. Division");
            System.out.println("5. ReEnter the Numbers");
            System.out.println("6. Exit");

            System.out.print("Enter your choice: ");
            choice = sc.nextInt();

            if (choice >= 1 && choice <= 4) {
                performCalculation(num1, num2, choice);
            } else if (choice == 5) {
                assignNumbers(sc);
            } else if (choice == 6) {
                System.out.println("Exiting the program. Goodbye!");
            } else {
                System.out.println("Invalid choice! Please try again.");
            }

        } while (choice != 6);
    }

    public static void assignNumbers(Scanner sc) {
        System.out.println("Enter the value for 1st Number: ");
        int num1 = sc.nextInt();

        System.out.println("Enter the value for 2nd Number: ");
        int num2 = sc.nextInt();
    }

    public static void performCalculation(int a, int b, int choice) {
        switch (choice) {
            case 1:
                addition(a, b);
                break;
            case 2:
                subtraction(a, b);
                break;
            case 3:
                multiplication(a, b);
                break;
            case 4:
                division(a, b);
                break;
        }
    }

    public static void addition(int a, int b) {
        int sum = a + b;
        System.out.println("The result of Addition is: " + sum);
    }

    public static void subtraction(int a, int b) {
        int sub = a - b;
        System.out.println("The result of Subtraction is: " + sub);
    }

    public static void multiplication(int a, int b) {
        int mul = a * b;
        System.out.println("The result of Multiplication is: " + mul);
    }

    public static void division(int a, int b) {
        if (b == 0) {
            System.out.println("Error: Division by zero is not allowed.");
        } else {
            float div = (float) a / b;
            System.out.println("The result of Division is: " + div);
        }
    }
}

class employee {
    private int employeeNumber;
    private String employeeName;
    protected int salary;

    public void getData(int empno, String empname) {
        employeeNumber = empno;
        employeeName = empname;
    }

    public void putData() {
        System.out.println("Employee Number: " + employeeNumber);
        System.out.println("Employee Name: " + employeeName);
        System.out.println("Employee Salary: " + salary);
    }
}

class hourlyBasis extends employee {
    private int hours;
    private int rate;

    public void getHourlyData(int h, int r) {
        hours = h;
        rate = r;
    }

    public void calculate() {
        salary = hours * rate;
    }
}

class monthlyBasis extends employee {
    private int basic;
    private int hra;
    private int da;

    public void getMonthlyData(int b, int h, int d) {
        basic = b;
        hra = h;
        da = d;
    }

    public void calculate() {
        salary = basic + (basic * hra / 100) + (basic * da / 100);
    }

}


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
