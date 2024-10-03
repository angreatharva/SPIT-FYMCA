#include <iostream>
#define max 100
using namespace std;

int n, c, arr[max], key;

class Sequential
{
public:
    // Function to input array elements from the user
    void input()
    {
        cout << "Enter how many elements you want to store ";
        cin >> n;
        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Position ";
            cin >> arr[i];
        }
    }

    // Function to display choice options
    void choice()
    {
        cout << "Array:- ";
        for (int e = 0; e < n; e++)
        {
            cout << arr[e] << " ";
        }
        cout << endl;

        cout << "Make your Choice. " << endl;
        cout << "1.) Search a Key. " << endl;
        cout << "2.) Exit. " << endl;
        cin >> c;

        // If user doesn't choose to exit, call search function
        if (c != 2)
        {
            search();
        }
    }

    // Function to search for a key in the array
    void search()
    {
        cout << "Enter the key you want to search. " << endl;
        cin >> key;

        int pos = -1;
        for (int i = 0; i < n; i++)
        {
            // If key is found, store its index in pos and break out of loop
            if (key == arr[i])
            {
                pos = i;
                break;
            }
        }

        // If pos is -1, key is not found, insert it at the end of the array
        if (pos == -1)
        {
            cout << "Element " << key << " is not found\n"
                 << "\n";

            // Add the key to the end of the array and increment the size
            arr[n] = key;
            n++;
            cout << "Key is Inserted at the end for the Array" << endl;

            // Display the updated array
            cout << "New Array:- ";
            for (int e = 0; e < n; e++)
            {
                cout << arr[e] << " ";
            }
            cout << endl;
        }
        // If key is found, display the index
        else
        {
            cout << "Element " << key << " is found at index " << pos << "\n"
                 << '\n';
        }
    }
};

int main()
{
    Sequential s;
    s.input();
    do
    {
        s.choice();
    } while (c == 1);

    return 0;
}
