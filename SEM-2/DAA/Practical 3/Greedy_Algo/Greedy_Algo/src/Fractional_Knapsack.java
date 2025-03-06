import java.util.Arrays;

public class Fractional_Knapsack {
    public static void main(String[] args) {
        Object[] object = {
                new Object(1, 3, 10),
                new Object(2, 3, 15),
                new Object(3, 2, 10),
                new Object(4, 5, 20),
                new Object(4, 1, 8),
        };
        Arrays.sort(object, (a, b) -> Double.compare(b.ratio, a.ratio));

        int maxWeight = 0;
        int maxProfit = 0;

        int maximumWeight = 10;


        for(Object obj : object) {
            if(maxWeight <= maximumWeight){
                if(maxWeight+ obj.weight > maximumWeight){
                   int x = (obj.profit * (maximumWeight - maxWeight))/obj.weight;
                   maxProfit += x;
                   maxWeight +=maximumWeight - maxWeight;
                }
                else {
                    maxWeight += obj.weight;
                    maxProfit += obj.profit;
                }
            }

        }

        System.out.println("maxWeight: "+maxWeight);
        System.out.println("maxProfit: "+maxProfit);
    }
}
class Object {
    int id, weight, profit;
    double ratio;

    Object(int id, int weight, int profit) {
        this.id = id;
        this.weight = weight;
        this.profit = profit;
        this.ratio = (double) profit /weight;
    }
}
