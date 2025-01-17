#include <iostream>
#define max 100
using namespace std;
int n, arr[max], low, high, mid, pos = -1, key;
class binary
{
public:
    void input()
    {
        char ch;
        do
        {
            if (n >= max)
            {
                cout << "Array is full! Can't input more elements.\n";
                break;
            }

            cout << "Enter data at Index " << n << "(or press 'x' to stop): ";
            cin >> ch;
            if (ch == 'x')
            {
                break;
            }

            arr[n] = ch - '0';
            n++;

        } while (true);
    }
    void sort()
    {
        for (int i = 0; i < n; i++)
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
            cout << "Key not found";
        }
        else
        {
            cout << "Key " << key << " found at Index" << pos;
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
