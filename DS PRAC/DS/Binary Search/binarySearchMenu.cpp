#include <iostream>
#define max 100
using namespace std;
int n, c, arr[max], low, high, mid, pos = -1, key;

class binary
{
public:
    // Function to input array elements from the user
    void input()
    {
        cout << "Enter how many elements you want to store ";
        cin >> n;
        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Index ";
            cin >> arr[i];
        }
    }
    void sort()
    {
        for (int i = 0; i < n - 1; i++)
        {
            for (int j = 0; j < n - i - 1; j++)
            {
                if (arr[j] > arr[j + 1])
                {
                    int temp;
                    temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }
    // Function to display choice options
    void choice()
    {
        cout << "Array:- ";
        for (int e = 0; e < n; e++)
        {
            cout << arr[e] << " ";
        }
        cout << endl;

        cout << "Make your Choice. " << endl;
        cout << "1.) Search a Key. " << endl;
        cout << "2.) Exit. " << endl;
        cin >> c;

        if (c != 2)
        {
            search();
        }
    }
    void search()
    {
        cout << "Enter key to be searched ";
        cin >> key;
        low = 0, high = n - 1;
        while (high >= low)
        {
            mid = (low + high) / 2;
            if (key == arr[mid])
            {
                pos = mid;
                break;
            }
            else if (key < arr[mid])
            {
                high = mid - 1;
            }
            else
            {
                low = mid + 1;
            }
        }
        if (pos == -1)
        {
            cout << "Key not found" << endl;
            // Add the key to the end of the array and increment the size
            arr[n] = key;
            n++;
            cout << "Key is Inserted at the Array" << endl;
            sort();
            // Display the updated array
            cout << "New Array:- ";
            for (int e = 0; e < n; e++)
            {
                cout << arr[e] << " ";
            }
            cout << endl;
        }
        else
        {
            cout << "Key " << key << " found at index " << pos << endl;
            pos = -1;
        }
    }
};
int main()
{
    binary b;
    b.input();
    b.sort();
    do
    {
        b.choice();
    } while (c == 1);

    return 0;
}