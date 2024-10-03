#include <iostream>
#define max 100
using namespace std;
int n, arr[max], low, high, mid, pos = -1, key;
class binary
{
public:
    void input()
    {
        cout << "Enter how many elements you want to store \n";
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

        cout << "Sorted Array ";
        for (int e = 0; e < n; e++)
        {
            cout << arr[e] << " ";
        }
        cout << endl;
    }
    void search()
    {
        cout << "Enter key to be searched  ";
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
            cout << "Key not found";
        }
        else
        {
            cout << "Key " << key << " found at index " << pos;
        }
    }
};
int main()
{
    binary b;
    b.input();
    b.sort();
    b.search();
    return 0;
}