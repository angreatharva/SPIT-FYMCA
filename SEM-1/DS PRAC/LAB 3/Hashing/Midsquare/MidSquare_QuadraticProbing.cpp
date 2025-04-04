#include <iostream>
#include <string>
using namespace std;
#define max 100

int n, m, arr[max], arrM[max], collision = 0;
bool err = false;

class Midsquare
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
            arrM[i] = 0; // Initialize the hash table
        }
    }

    void placing()
    {
        for (int i = 0; i < m; i++)
        {
            int hk = msquare(n, arr[i]);
            linearProbing(hk, i);
        }
    }

    int msquare(int n, int k)
    {
        long long prod = k * k;
        string pd = to_string(prod);
        int length = pd.length();
        string val = "";
        int value = 0;

        int mid = length / 2;

        if (length % 2 == 0)
        {
            val = string(1, pd.at(mid - 1)) + string(1, pd.at(mid));
        }
        else
        {
            val = pd.at(mid);
        }

        value = stoi(val);

        return value % n; // Return index based on the table size
    }

    void linearProbing(int hk, int i)
    {
        while (arrM[hk] != 0) // Check for collision
        {
            hk = (hk + 1) % n; // Move to the next index
            collision++;
        }
        arrM[hk] = arr[i]; // Place the element
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
    Midsquare ms;
    ms.input();
    if (!err)
    {
        ms.placing();
        ms.output();
    }
    return 0;
}
