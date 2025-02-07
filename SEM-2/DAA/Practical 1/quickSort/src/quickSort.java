import java.util.Arrays;
import java.util.Scanner;

public class quickSort {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Enter the size of the data");
        int n = sc.nextInt();

        int[] arr = new int[n];

        System.out.println("Enter the data");
        for(int i = 0; i < n; i++){
            System.out.print("Enter the data for index " + i+" : ");
            arr[i] = sc.nextInt();
        }

        int low = 0;
        int high = arr.length-1;
        quickSort(arr,low,high);
        System.out.println(Arrays.toString(arr));
    }
    static void quickSort(int[] arr, int low, int high){
        if (low < high)
        {

            int pivotIndex = partition(arr, low, high);

            quickSort(arr, low, pivotIndex - 1);
            quickSort(arr, pivotIndex + 1, high);
        }
    }
    static int partition(int[] arr, int low, int high) {
        int pivot = low;
        int i = low + 1;
        int j = high;

        while (i <= j)
        {
            while (i <= j && arr[pivot] > arr[i])
            {
                i++;
            }

            while (i <= j && arr[pivot] < arr[j])
            {
                j--;
            }

            if (i < j)
            {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        int temp = arr[j];
        arr[j] = arr[pivot];
        arr[pivot] = temp;
        return j;
    }
}
