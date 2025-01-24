import java.util.Scanner;

public class bank {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        Account acc = new Account(1, "Atharva", 1000);

        boolean breakFlow;
        do {
            System.out.println("\nBank Menu");
            System.out.println("1. Deposit");
            System.out.println("2. Withdraw");
            System.out.println("3. Check Balance");
            System.out.println("4. Exit");
            System.out.print("Enter your choice: ");

            int choice = sc.nextInt();
            breakFlow = true;

            switch (choice) {
                case 1:
                    System.out.print("Enter amount to deposit: ");
                    double depositAmount = sc.nextDouble();
                    acc.deposit(depositAmount);
                    break;
                case 2:
                    System.out.print("Enter amount to withdraw: ");
                    double withdrawAmount = sc.nextDouble();
                    acc.withdraw(withdrawAmount);
                    break;
                case 3:
                    acc.checkBalance();
                    break;
                case 4:
                    System.out.println("Thank you for using the bank. Goodbye!");
                    breakFlow = false;
                    break;
                default:
                    System.out.println("Invalid choice. Please enter proper value.");
            }
        } while (breakFlow);
    }
    static class Account {
        private int accNumber;
        private String name;
        private double balance;

        public Account(int accNumber, String name, double initialBalance) {
            this.accNumber = accNumber;
            this.name = name;
            this.balance = initialBalance;
        }

        void withdraw(double amount) {
            if (amount > balance) {
                System.out.println("You have insufficient balance.");
            } else {
                balance -= amount;
                System.out.println("Debited " + amount + " from your account.");
                System.out.println("Your current balance is: " + balance);
            }
        }

        void deposit(double amount) {
            balance += amount;
            System.out.println("Credited " + amount + " to your account.");
            System.out.println("Your current balance is: " + balance);
        }

        void checkBalance() {
            System.out.println("Your current balance is: " + balance);
        }
    }
}
