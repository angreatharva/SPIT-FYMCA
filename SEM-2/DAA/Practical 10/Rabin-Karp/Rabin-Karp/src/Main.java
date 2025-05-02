import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Enter the text: ");
        String text = scanner.nextLine();

        System.out.println("Enter the pattern to search: ");
        String pattern = scanner.nextLine();

        int q = 101; // A prime number

        System.out.println("\nSearching for pattern using Rabin-Karp Algorithm...");
        RabinKarp.rabinKarpSearch(text, pattern, q);
    }
}


//Enter the text:
//THIS IS A TEST TEXT
//Enter the pattern to search:
//TEST
//
//Searching for pattern using Rabin-Karp Algorithm...
//Pattern found at index 10
