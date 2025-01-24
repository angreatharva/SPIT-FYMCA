import java.util.Arrays;
import java.util.Scanner;

public class mergerSort {
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
        mergeSort(arr,low,high);
        System.out.println(Arrays.toString(arr));
    }
    static void mergeSort(int[] arr,int low,int high){
        if (low < high) {
            int mid = (low + high) / 2;
            mergeSort(arr,low, mid);
            mergeSort(arr,mid + 1, high);
            merge(arr,low, mid, high);
        }

    }
    static void merge(int[] arr,int low, int mid, int high) {
        int l1 = mid - low + 1;
        int l2 = high - mid;

        int[] a1 = new int[l1];
        int[] a2 = new int[l2];

        for (int i = 0; i < l1; i++) {
            a1[i] = arr[low + i];
        }

        for (int j = 0; j < l2; j++) {
            a2[j] = arr[mid + 1 + j];
        }

        int i = 0, j = 0, k = low;

        while (i < l1 && j < l2) {
            if (a1[i] < a2[j]) {
                arr[k] = a1[i];
                i++;
            } else {
                arr[k] = a2[j];
                j++;
            }
            k++;
        }

        while (i < l1) {
            arr[k] = a1[i];
            i++;
            k++;
        }

        while (j < l2) {
            arr[k] = a2[j];
            j++;
            k++;
        }
    }


}
