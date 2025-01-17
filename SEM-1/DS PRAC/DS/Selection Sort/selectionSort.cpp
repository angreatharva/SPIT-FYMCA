#include <iostream>
#define max 100
using namespace std;

int arr[max], n, pass = 1, max_ele_index;

class SelectionSort
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
    void selectionSort()
    {

        for (int i = 0; i < n; i++)
        {
            max_ele_index = i;
            for (int j = i + 1; j < n; j++)
            {
                if (arr[j] < arr[max_ele_index])
                {
                    max_ele_index = j;
                }
            }
            if (max_ele_index != i)
            {
                int temp = arr[i];
                arr[i] = arr[max_ele_index];
                arr[max_ele_index] = temp;
            }
            else
            {
                continue;
            }
            cout << "Pass " << pass << ": ";
            for (int e = 0; e < n; e++)
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
    SelectionSort ss;
    ss.input();
    ss.selectionSort();
    return 0;
}