#include <iostream>
using namespace std;
#define max 100

int n, m, arr[max], arrM[max], collision = 0;
bool err = false;

class ModuloDivision
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
            int hk = mdivision(n, arr[i]);
            quadraticProbing(hk, i);
        }
    }

    int mdivision(int n, int k)
    {
        return k % n;
    }

    void quadraticProbing(int hk, int i)
    {
        int step = 0;
        while (true)
        {
            int newIndex = (hk + step * step) % n;

            if (arrM[newIndex] == 0)
            {
                arrM[newIndex] = arr[i];
                break;
            }
            else
            {
                collision++;
                step++;
            }
        }
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
    ModuloDivision md;
    md.input();
    if (!err)
    {
        md.placing();
        md.output();
    }
    return 0;
}
