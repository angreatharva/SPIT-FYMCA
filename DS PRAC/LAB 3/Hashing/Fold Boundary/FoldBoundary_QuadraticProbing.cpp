#include <iostream>
#include <algorithm>
#include <string>

using namespace std;
#define MAX_LEN 100

int n, m, arr[MAX_LEN], arrM[MAX_LEN], num, digits[MAX_LEN], collision = 0;
bool err = false;

class FoldBoundary
{
public:
    void input()
    {
        cout << "Enter how many elements you want to store: ";
        cin >> m;
        for (int i = 0; i < m; i++)
        {
            cout << "Enter the data for " << i << " Index: ";
            cin >> arr[i];
        }
        cout << "Array: ";
        for (int i = 0; i < m; i++)
        {
            cout << arr[i] << " ";
        }
        cout << endl;
        cout << "Enter Number of locations: ";
        cin >> n;

        if (n < m)
        {
            cout << "Size of Hash Table must be greater than or equal to the no. of elements";
            err = true;
            return;
        }

        fill(begin(arrM), begin(arrM) + n, 0); // Initialize hash table to 0
    }

    void placing()
    {
        for (int i = 0; i < m; i++)
        {
            int hk = fshift(n, arr[i]);
            quadraticProbing(hk, i);
        }
    }

    int fshift(int n, int k)
    {
        int value = 0;

        int len = to_string(n).length();

        string str = to_string(k);

        for (int i = str.length(); i > 0; i -= len)
        {
            int start = max(0, i - len);
            string part = str.substr(start, i - start);

            while (part.length() < len)
            {
                part = "0" + part;
            }

            if (i == str.length() || start == 0)
            {
                reverse(part.begin(), part.end());
            }

            value += stoi(part);

            int max_value = 1;
            for (int j = 0; j < len; j++)
            {
                max_value *= 10; // Multiply by 10 'len' times to get 10^len
            }
            // Ensure that value is restricted to last 'len' digits
            value = value % max_value;
        }
        return value;
    }

    void quadraticProbing(int hk, int i)
    {
        int offset = 0;
        while (offset < n)
        {
            int newIndex = (hk + offset * offset) % n; // Quadratic probing formula
            if (arrM[newIndex] == 0)
            {
                arrM[newIndex] = arr[i];
                return;
            }
            collision++;
            offset++;
        }
        cout << "Error: Hash table is full, cannot insert " << arr[i] << endl;
    }

    void output()
    {
        cout << "No. of Collision: " << collision << endl;
        cout << "Value | Index " << endl;
        for (int i = 0; i < n; i++)
        {
            if (arrM[i] != 0)
            {
                cout << arrM[i] << " | " << i << endl;
            }
        }
        cout << endl;
    }
};

int main()
{
    FoldBoundary fb;
    fb.input();
    if (!err)
    {
        fb.placing();
        fb.output();
    }
    return 0;
}
