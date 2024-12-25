#include <iostream>
#include <algorithm>
#include <string>

using namespace std;
#define MAX_LEN 100

int n, m, arr[MAX_LEN], arrM[MAX_LEN], num, digits[MAX_LEN], collision = 0;
bool err = false;

class FoldShift
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
        for (int i = 0; i < n; i++)
        {
            arrM[i] = 0;
        }
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

            value += stoi(part);

            int max_value = 1;
            for (int j = 0; j < len; j++)
            {
                max_value *= 10;
            }
            value = value % max_value;
        }
        return value % n;
    }

    void quadraticProbing(int hk, int i)
    {
        int original_hk = hk;
        int j = 1;

        while (arrM[hk] != 0)
        {
            hk = (original_hk + j * j) % n;
            collision++;
            j++;
        }
        arrM[hk] = arr[i];
    }

    void output()
    {
        cout << "No. of Collisions: " << collision << endl;
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
    FoldShift fs;
    fs.input();
    if (!err)
    {
        fs.placing();
        fs.output();
    }
    return 0;
}
