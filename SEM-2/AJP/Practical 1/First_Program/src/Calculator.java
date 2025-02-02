import java.util.Scanner;

public class Calculator
{
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("\n*Calculator*");
        Calculator.performCalculator(sc);
    }
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
