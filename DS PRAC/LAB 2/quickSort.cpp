#include <iostream>
#define max 100
using namespace std;
int n, arr[max];

class QuickSort
{
public:
    void input()
    {
        cout << "Enter how many elements you want to store: ";
        cin >> n;
        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Index: ";
            cin >> arr[i];
        }
        cout << "Array: ";
        for (int i = 0; i < n; i++)
        {
            cout << arr[i] << " ";
        }
        cout << endl;
    }

    void quickSort(int arr[], int low, int high)
    {
        if (low < high)
        {

            int pivotIndex = partition(arr, low, high);

            quickSort(arr, low, pivotIndex - 1);
            quickSort(arr, pivotIndex + 1, high);
        }
    }

    int partition(int arr[], int low, int high)
    {
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

    void output()
    {
        cout << "sorted Array is: ";
        for (int k = 0; k < n; k++)
        {
            cout << arr[k] << " ";
        }
    }
};

int main()
{

    QuickSort qs;
    qs.input();
    qs.quickSort(arr, 0, n - 1);
    qs.output();

    return 0;
}