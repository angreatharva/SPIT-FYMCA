#include <iostream>
using namespace std;

class Heap
{
    int arr[100];
    int size;

public:
        void insertElement()
    {
        int n;
        cout << "Enter the number of elements to insert: ";
        cin >> n;

        if (size + n > 100)
        {
            cout << "Heap can only hold 100 elements.\n";
            return;
        }

        cout << "Enter " << n << " elements: ";
        for (int i = 0; i < n; ++i)
        {
            cin >> arr[size++];
        }
    }

    void heapify(int n, int i, bool isMaxHeap)
    {
        while (true)
        {
            int parent = i;
            int left = 2 * i + 1;
            int right = 2 * i + 2;

            if (isMaxHeap)
            {
                if (left < n && arr[left] > arr[parent])
                    parent = left;
                if (right < n && arr[right] > arr[parent])
                    parent = right;
            }
            else
            {
                if (left < n && arr[left] < arr[parent])
                    parent = left;
                if (right < n && arr[right] < arr[parent])
                    parent = right;
            }

            if (parent == i)
                break;

            swap(arr[i], arr[parent]);
            i = parent;
        }
    }

    void heapSort(bool isMaxHeap)
    {
        for (int i = size / 2 - 1; i >= 0; i--)
            heapify(size, i, isMaxHeap);

        for (int i = size - 1; i > 0; i--)
        {
            swap(arr[0], arr[i]);
            heapify(i, 0, isMaxHeap);
        }
    }

    void displayHeap(bool isMaxHeap)
    {
        heapSort(isMaxHeap);
        cout << (isMaxHeap ? "Max Heap (big to small): " : "Min Heap (small to big): ");
        for (int i = 0; i < size; ++i)
            cout << arr[i] << " ";
        cout << "\n";
    }
};

int main()
{
    Heap heap;
    int choice;

    do
    {
        cout << "\n1. Insert elements";
        cout << "\n2. Display as Min Heap";
        cout << "\n3. Display as Max Heap";
        cout << "\n4. Exit";
        cout << "\nEnter your choice: ";
        cin >> choice;

        switch (choice)
        {
        case 1:
            heap.insertElement();
            break;
        case 2:
            heap.displayHeap(false); // Min Heap
            break;
        case 3:
            heap.displayHeap(true); // Max Heap
            break;
        case 4:
            cout << "Exiting.\n";
            break;
        default:
            cout << "Invalid choice! Try again.\n";
        }
    } while (choice != 4);

    return 0;
}
