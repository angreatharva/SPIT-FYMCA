
#include <iostream>
#define max 100
using namespace std;
int n,arr[max],pass=1;


class BubbleSort {
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
	void bsort() {
		for(int i = 0; i < n-1; i++) {
			for(int j = 0; j < n-i-1; j++) {
				if(arr[j] > arr[j+1]) {
					int temp = arr[j];
					arr[j] = arr[j+1];
					arr[j+1] = temp;
				}
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
	BubbleSort bs;
	bs.input();
	bs.bsort();
	bs.display();

	return 0;
}