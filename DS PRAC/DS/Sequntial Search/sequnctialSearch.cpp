#include <iostream>
#define max 100
using namespace std;

int arr[max], key;

class Sequential
{
public:
    int n = 0;

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
            cout << "Enter the data for position " << n << " (or press 'x' to stop): ";
            cin >> ch;
            if (ch == 'x')
            {
                break;
            }

            arr[n] = ch - '0';
            n++;
        } while (true);
    }

    void search()
    {
        cout << "Enter the element you want to search: ";
        cin >> key;

        int pos = -1;
        for (int i = 0; i < n; i++)
        {
            if (key == arr[i])
            {

                pos = i;
                break;
            }
        }

        if (pos == -1)

        {
            cout << "Element " << key << " is not found\n";
        }
        else
        {
            cout << "Element " << key << " is found at index " << pos << "\n";
        }
    }
};

int main()
{
    Sequential s;
    s.input();
    s.search();
    return 0;
}
