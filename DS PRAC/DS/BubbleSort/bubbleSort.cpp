#include <iostream>
#include <algorithm>
#define max 100
using namespace std;

int arr[max], n, pass = 1;

class BubbleSort
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

    void bubbleSort()
    {

        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n - i - 1; j++)
            {
                if (arr[j] > arr[j + 1])
                {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }

            cout << "Pass " << pass << ": ";
            for (int e = 0; e < n; e++)
            {
                cout << arr[e] << " ";
            }
            cout << endl;
            pass++;
            if (std::is_sorted(arr, arr + n))
            {
                break;
            }
        }
    }
};

int main()
{
    BubbleSort bs;
    bs.input();
    bs.bubbleSort();
    return 0;
}