import java.util.Scanner;

public class RabinKarp {
    static final int d = 256;

    public static void rabinKarpSearch(String text, String pattern, int q) {
        int m = pattern.length();
        int n = text.length();
        int i, j;
        int p = 0;
        int t = 0;
        int h = 1;

//        "pow(d, m-1)%q"
        for (i = 0; i < m - 1; i++)
            h = (h * d) % q;

        for (i = 0; i < m; i++) {
            p = (d * p + pattern.charAt(i)) % q;
            t = (d * t + text.charAt(i)) % q;
        }

        for (i = 0; i <= n - m; i++) {
            if (p == t) {
                for (j = 0; j < m; j++) {
                    if (text.charAt(i + j) != pattern.charAt(j))
                        break;
                }

                if (j == m)
                    System.out.println("Pattern found at index " + i);
            }

            if (i < n - m) {
                t = (d * (t - text.charAt(i) * h) + text.charAt(i + m)) % q;

                if (t < 0)
                    t = (t + q);
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Enter the text: ");
        String text = scanner.nextLine();

        System.out.println("Enter the pattern to search: ");
        String pattern = scanner.nextLine();

        int q = 101;

        rabinKarpSearch(text, pattern, q);
    }
}
