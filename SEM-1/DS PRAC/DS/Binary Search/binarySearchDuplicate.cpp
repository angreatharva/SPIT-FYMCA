#include <iostream>
#define max 100
using namespace std;
int n, arr[max], op[max], count, low, high, mid, pos = -1, key;
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
        cout << "Enter key to be searched: ";
        cin >> key;
        count = 0;
        low = 0;
        high = n - 1;
        int pos = -1;

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
            cout << "Key not found." << endl;
            return;
        }

        int left = pos, right = pos;

        while (left >= 0 && arr[left] == key)
        {
            op[count] = left;
            count++;
            left--;
        }

        while (right < n && arr[right] == key)
        {
            if (right != pos)
            {
                op[count] = right;
                count++;
            }
            right++;
        }

        for (int i = 0; i < count; i++)
        {
            cout << "Key " << key << " found at index " << op[i] << endl;
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
