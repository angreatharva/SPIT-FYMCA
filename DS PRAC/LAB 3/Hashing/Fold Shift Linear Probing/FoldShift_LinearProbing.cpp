#include <iostream>
#include <algorithm>
#include <string>

using namespace std;
#define MAX_LEN 100

int n, m, arr[MAX_LEN], arrM[MAX_LEN], num,digits[MAX_LEN], collision = 0;

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

		arrM[n] = {0};

	}

	void placing()
	{
		for (int i = 0; i < m; i++)
		{
			int hk = fshift(n, arr[i]);
			linearProbing(hk, i);
		}
	}

	int fshift(int n, int k)
	{
    int value = 0;

    int len = to_string(n).length();

    string str = to_string(k);

    for (int i = str.length(); i > 0; i -= len)
    {
        int start = max(0, i - len);  
        string part = str.substr(start, i - start); 
        
        value += stoi(part);
        
        int max_value = 1;
        for (int j = 0; j < len; j++) {
            max_value *= 10;  // Multiply by 10 'len' times to get 10^len
        }
        // Ensure that value is restricted to last 'len' digits
        value = value % max_value; 
    }
    // cout << "value" << value;
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
	DigitExtraction de;
	de.input();
	de.placing();
	de.output();
	return 0;
}