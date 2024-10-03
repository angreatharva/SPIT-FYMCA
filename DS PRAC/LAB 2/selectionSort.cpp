
#include <iostream>
#define max 100
using namespace std;
int n,arr[max],pass=1;


class SelectionSort {
public:
	void input()
	{
		cout<<"Enter how many elements you want to store: ";
		cin>>n;
		for (int i=0; i<n; i++)
		{
			cout<<"Enter the data for "<<i <<" Index: ";
			cin>>arr[i];
		}
		cout << "Array: ";
		for(int i = 0; i < n; i++) {
			cout << arr[i] << " ";
		}
		cout << endl;
	}
	void ssort() {
		for(int i = 0; i < n; i++) {
			int minIndex = i;
			for(int j = i+1; j < n; j++) {
				if(arr[j] < arr[minIndex]) {
					minIndex = j;
				}
			}
			if (minIndex != i) {
				int temp = arr[minIndex];
				arr[minIndex] = arr[i];
				arr[i] = temp;

			}
			cout << "Pass " <<  pass << ":";
			for(int i = 0; i< n ; i++) {
				cout << arr[i] << " ";

			}
			pass++;
			cout << endl;

		}
	}

	void display() {
		cout << "Sorted Array: ";
		for(int i = 0; i < n; i++) {
			cout << arr[i] << " ";
		}
		cout << endl;
	}
};

int main()
{
	SelectionSort ss;
	ss.input();
	ss.ssort();
	ss.display();

	return 0;
}