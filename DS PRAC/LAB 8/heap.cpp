#include <iostream>
using namespace std;

class Heap
{
    int arr[100];
    int size;

public:
    Heap() : size(0) {}

    void insertElement()
    {
        int n;
        cout << "Enter the number of elements to insert into the heap: ";
        cin >> n;
        cout << "Enter " << n << " elements: ";
        for (int i = 0; i < n; ++i)
        {
            int element;
            cin >> element;
            arr[size++] = element;
        }
        cout << "Heap constructed successfully!\n";
    }

    void heapifyIterative(int arr[], int n, int i, bool isMaxHeap)
    {
        while (true)
        {
            int largestOrSmallest = i;
            int left = 2 * i + 1;
            int right = 2 * i + 2;

            if (isMaxHeap)
            {
                if (left < n && arr[left] > arr[largestOrSmallest])
                {
                    largestOrSmallest = left;
                }
                if (right < n && arr[right] > arr[largestOrSmallest])
                {
                    largestOrSmallest = right;
                }
            }
            else
            {
                if (left < n && arr[left] < arr[largestOrSmallest])
                {
                    largestOrSmallest = left;
                }
                if (right < n && arr[right] < arr[largestOrSmallest])
                {
                    largestOrSmallest = right;
                }
            }

            if (largestOrSmallest == i)
                break;
            swap(arr[i], arr[largestOrSmallest]);
            i = largestOrSmallest;
        }
    }

    void heapSort(bool isMaxHeap)
    {
        for (int i = size / 2 - 1; i >= 0; i--)
        {
            heapifyIterative(arr, size, i, isMaxHeap);
        }

        for (int i = size - 1; i > 0; i--)
        {
            swap(arr[0], arr[i]);
            heapifyIterative(arr, i, 0, isMaxHeap);
        }
    }

    void displayMinHeap()
    {
        cout << "Max Heap elements (big to small): ";
        heapSort(false);
        for (int i = 0; i < size; ++i)
        {
            cout << arr[i] << " ";
        }
        cout << "\n";
    }

    void displayMaxHeap()
    {
        cout << "min Heap elements (small to big): ";
        heapSort(true);
        for (int i = 0; i < size; ++i)
        {
            cout << arr[i] << " ";
        }
        cout << "\n";
    }
};

int main()
{
    Heap heap;
    int choice;

    do
    {
        cout << "\n--- HEAP MENU ---";
        cout << "\n1. Insert elements (Build Heap)";
        cout << "\n2. Display Min Heap";
        cout << "\n3. Display Max Heap";
        cout << "\n4. Exit";
        cout << "\nEnter your choice: ";
        cin >> choice;

        switch (choice)
        {
        case 1:
            heap.insertElement();
            break;
        case 2:

            heap.displayMaxHeap();
            break;
        case 3:
            heap.displayMinHeap();
            break;
        case 4:
            cout << "Exiting the program.\n";
            break;
        default:
            cout << "Invalid choice! Please try again.\n";
        }
    } while (choice != 4);

    return 0;
}
