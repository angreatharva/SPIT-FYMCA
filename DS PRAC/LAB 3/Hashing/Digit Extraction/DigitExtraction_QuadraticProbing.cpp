#include <iostream>
#include <algorithm>

using namespace std;
#define max 100

int n, m, arr[max], arrM[max], num, digits[max], collision = 0;
bool err = false;

class DigitExtraction
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

        cout << "Enter Number of digits for extraction: ";
        cin >> num;

        for (int i = 0; i < num; i++)
        {
            cout << "Enter the data for " << i << " Index: ";
            cin >> digits[i];
        }

        cout << "Digits Array: ";
        for (int i = 0; i < num; i++)
        {
            cout << digits[i] << " ";
        }
        cout << endl;
    }

    void placing()
    {
        for (int i = 0; i < m; i++)
        {
            int hk = dextraction(n, arr[i]);
            quadraticProbing(hk, i);
        }
    }

    int dextraction(int n, int k)
    {
        string val = "";
        int value;
        string key = to_string(k);

        int j = 0;
        int count = 1;

        for (int i = key.length() - 1; i >= 0; i--)
        {
            if (j < num && digits[j] == count)
            {
                val.push_back(key.at(i));
                j++;
            }
            count++;
        }
        reverse(val.begin(), val.end());
        value = stoi(val);

        return value % n; // Ensure the extracted value fits within the hash table
    }

    void quadraticProbing(int hk, int i)
    {
        int original_hk = hk;
        int j = 1; // Quadratic probing starts from 1

        while (arrM[hk] != 0)
        {
            hk = (original_hk + j * j) % n; // Quadratic probing: hk = (h(k) + j^2) % n
            collision++;
            j++;
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
    DigitExtraction de;
    de.input();
    if (!err)
    {
        de.placing();
        de.output();
    }
    return 0;
}
