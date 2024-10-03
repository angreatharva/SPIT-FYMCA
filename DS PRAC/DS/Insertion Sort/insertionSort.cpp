#include <iostream>
#define max 100
using namespace std;

int arr[max], n, pass = 1;

class InsertionSort
{
public:
    void input()
    {
        cout << "Enter how many elements you want to store \n";
        cin >> n;
        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Index ";
            cin >> arr[i];
        }
    }

    void insertionSort()
    {
        for (int i = 1; i < n; i++)
        {
            for (int j = i; j > 0; j--)
            {
                if (arr[j] < arr[j - 1])
                {
                    int temp = arr[j];
                    arr[j] = arr[j - 1];
                    arr[j - 1] = temp;
                }
            }

            cout << "Pass " << pass << ": ";
            for (int e = 0; e <= i; e++)
            {
                cout << arr[e] << " ";
            }
            cout << endl;
            pass++;
        }
    }
};
int main()
{
    InsertionSort is;
    is.input();
    is.insertionSort();
    return 0;
}