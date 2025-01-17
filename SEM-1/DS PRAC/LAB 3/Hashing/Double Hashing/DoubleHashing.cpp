#include <iostream>
#define Max_Size 100
using namespace std;

int n, m, arr[Max_Size], arrM[Max_Size], collision = 0;
bool err = false;

class DHashing
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
            cout << "Size of Hash Table must be greater than or equal to the number of elements.";
            err = true;
            return;
        }

        arrM[n] = {0};
    }

    void placing()
    {
        for (int i = 0; i < m; i++)
        {
            int key = arr[i];
            int h1 = key % n;
            int h2 = 1 + (key % (n - 1));
            int hk;

            for (int j = 0; j < n; j++)
            {
                hk = (h1 + j * h2) % n;

                if (arrM[hk] == 0)
                {
                    arrM[hk] = key;
                    break;
                }
                else
                {
                    collision++;
                }
            }
        }
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
    DHashing dh;
    dh.input();
    if (!err)
    {
        dh.placing();
        dh.output();
    }
    return 0;
}
