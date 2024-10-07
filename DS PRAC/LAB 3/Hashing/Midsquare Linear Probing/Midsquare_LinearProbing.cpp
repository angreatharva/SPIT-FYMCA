#include <iostream>
#include <string>
using namespace std;
#define max 100

int n, m, arr[max], arrM[max], collision = 0;

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

        arrM[n] = {0};
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
        int prod = k * k;
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

        return value;
    }

    void linearProbing(int hk, int i)
    {
        if (hk < n)
        {

            if (arrM[hk] == 0)
            {
                arrM[hk] = arr[i];
            }
            else
            {
                hk++;
                collision++;
                linearProbing(hk, i);
            }
        }
        else
        {
            hk = hk % n;
            linearProbing(hk, i);
        }
    }

    void output()
    {
        cout << "No. of Collision: " << collision << endl;
        for (int i = 0; i < n; i++)
        {
            cout << arrM[i] << " ";
        }
        cout << endl;
    }
};
int main()
{
    Midsquare ms;
    ms.input();
    ms.placing();
    ms.output();
    return 0;
}