import java.util.Arrays;

public class JobSequencing {

    public static void main(String[] args) {
        Job[] jobs = {
                new Job(1, 4, 70),
                new Job(2, 1, 80),
                new Job(3, 1, 30),
                new Job(4, 2, 100),
                new Job(5, 3, 40),
                new Job(6, 4, 20),
                new Job(7, 2, 90)
        };

        int n = jobs.length;
        jobSequencing(jobs, n);
    }

    static void jobSequencing(Job[] jobs, int n) {
        Arrays.sort(jobs, (a, b) -> b.profit - a.profit);

        int maxDeadline = 0;
        for (Job job : jobs) {
            maxDeadline = Math.max(maxDeadline, job.deadline);
        }

        int[] result = new int[maxDeadline + 1];
        boolean[] slot = new boolean[maxDeadline + 1];

        Arrays.fill(slot, false);

        int maxProfit = 0;
        int jobsDone = 0;

        for (Job job : jobs) {
            for (int j = job.deadline; j > 0; j--) {
                if (!slot[j]) {
                    result[j] = job.id;
                    slot[j] = true;
                    maxProfit += job.profit;
                    jobsDone++;
                    break;
                }
            }
        }

        System.out.println("Scheduled Jobs: ");
        for (int i = 1; i <= maxDeadline; i++) {
            if (slot[i]) {
                System.out.print("Job " + result[i] + " ");
            }
        }
        System.out.println("\nTotal Profit: " + maxProfit);
    }
}

class Job {
    int id, deadline, profit;

    Job(int id, int deadline, int profit) {
        this.id = id;
        this.deadline = deadline;
        this.profit = profit;
    }
}
