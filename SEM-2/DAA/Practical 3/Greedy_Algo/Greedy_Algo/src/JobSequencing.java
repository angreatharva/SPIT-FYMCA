import java.util.Arrays;

public class JobSequencing {

    public static void main(String[] args) {
        Job[] jobs = {
                new Job(1, 2, 50),
                new Job(2, 3, 10),
                new Job(3, 1, 60),

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
            if (job.profit < 0) continue;
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
