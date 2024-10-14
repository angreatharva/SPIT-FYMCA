#include <iostream>
using namespace std;
#define max 100

int n, m, arr[max], arrM[max], collision = 0;

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

        arrM[n] = {0};
    }

    void placing()
    {
        for (int i = 0; i < m; i++)
        {
            int hk = mdivision(n, arr[i]);
            linearProbing(hk, i);
        }
    }

    int mdivision(int n, int k)
    {
        int h;
        h = k % n;
        return h;
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
             if(arrM[i] != 0){
			cout << arrM[i] << " " << i <<endl;
		    }
        }
        cout << endl;
    }
};

int main()
{
    ModuloDivision md;
    md.input();
    md.placing();
    md.output();
    return 0;
}