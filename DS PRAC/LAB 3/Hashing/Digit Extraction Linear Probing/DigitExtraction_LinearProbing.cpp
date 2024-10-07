#include <iostream>
using namespace std;
#define max 100

int n, m, arr[max], arrM[max], num,digits[max], collision = 0;

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

		cout << "Enter Number of digits for extraction: ";
		cin>>num;

		for(int i = 0; i < num; i++) {
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
			linearProbing(hk, i);
		}
	}

	int dextraction(int n, int k)
	{
		string val = "";
		int value;
		string key = to_string(k);

		cout << "dextraction Array: ";

		for(int i = key.length() -1; i >= 0; i--) {
			cout << key.at(i) << " ";
		}
		 cout << endl;

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
	// de.output();
	return 0;
}