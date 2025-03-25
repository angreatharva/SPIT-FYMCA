import java.util.Arrays;
import java.util.Scanner;

class Job {
    String id;
    int deadline, profit;

    public Job(String id, int deadline, int profit) {
        this.id = id;
        this.deadline = deadline;
        this.profit = profit;
    }
}

public class Main {
    static void jobSequencing(Job[] jobs, int n) {
        // Sorting jobs in descending order of profit
        Arrays.sort(jobs, (a, b) -> b.profit - a.profit);

        // Finding maximum deadline to create schedule array
        int maxDeadline = 0;
        for (Job job : jobs) {
            maxDeadline = Math.max(maxDeadline, job.deadline);
        }

        // Array to store scheduled job IDs
        String[] schedule = new String[maxDeadline];
        // Slot availability tracker if slot is available or not
        boolean[] slotFilled = new boolean[maxDeadline];
        int totalProfit = 0;

        // Iterating through jobs and placing them in the latest available slot before the deadline
        for (Job job : jobs) {
            for (int j = Math.min(maxDeadline - 1, job.deadline - 1); j >= 0; j--) {
                if (!slotFilled[j]) {
                    schedule[j] = job.id;
                    slotFilled[j] = true;
                    totalProfit += job.profit;
                    break;
                }
            }
        }

        // Result
        System.out.println("\nOptimal Job Sequence:");
        for (String jobId : schedule) {
            if (jobId != null) System.out.print(jobId + " ");
        }
        System.out.println("\nTotal Profit: " + totalProfit);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter number of jobs: ");
        int n = scanner.nextInt();
        Job[] jobs = new Job[n];

        // Inputs
        for (int i = 0; i < n; i++) {
            System.out.print("Enter Job ID: ");
            String id = scanner.next();
            System.out.print("Enter Deadline: ");
            int deadline = scanner.nextInt();
            System.out.print("Enter Profit: ");
            int profit = scanner.nextInt();
            jobs[i] = new Job(id, deadline, profit);
            System.out.println();
        }

        // Find optimal job sequence
        jobSequencing(jobs, n);

        scanner.close();
    }
}
