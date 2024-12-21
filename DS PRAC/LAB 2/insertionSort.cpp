
#include <iostream>
#define max 100
using namespace std;
int n, arr[max], pass = 1;

class InsertionSort
{
public:
	void input()
	{
		cout << "Enter how many elements you want to store: ";
		cin >> n;
		for (int i = 0; i < n; i++)
		{
			cout << "Enter the data for " << i << " Index: ";
			cin >> arr[i];
		}
		cout << "Array: ";
		for (int i = 0; i < n; i++)
		{
			cout << arr[i] << " ";
		}
		cout << endl;
	}
	void isort()
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
			cout << "Pass " << pass << ":";
			for (int k = 0; k <= i; k++)
			{
				cout << arr[k] << " ";
			}
			pass++;
			cout << endl;
		}
	}

	void display()
	{
		cout << "Sorted Array: ";
		for (int i = 0; i < n; i++)
		{
			cout << arr[i] << " ";
		}
		cout << endl;
	}
};

int main()
{
	InsertionSort is;
	is.input();
	is.isort();
	is.display();

	return 0;
}