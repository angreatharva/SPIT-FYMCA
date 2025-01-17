#include <iostream>
using namespace std;

const int MAX = 100;
int n, arr[MAX];

class RadixSort {
public:
	void input() {
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

	int getMax() {
		int max = arr[0];
		for(int i = 1; i < n; i++) {
			if(arr[i] > max) {
				max = arr[i];
			}
		}
		return max;

	}

	void countSort(int div) {
		int output[MAX];
		int count[10] = {0};

		for (int i = 0; i < n; i++) {
			count[(arr[i] / div) % 10]++;
		}
		for (int i = 1; i < 10; i++) {
			count[i] += count[i - 1];
		}
		for (int i = n - 1; i >= 0; i--) {
			output[count[(arr[i] / div) % 10]-1] = arr[i];
			count[(arr[i] / div) % 10]--;
		}

		for (int i = 0; i < n; i++) {
			arr[i] = output[i];
		}
	}

	void radixSort() {
		int m = getMax();
		cout << "Max element: " << m << endl;

		for(int div = 1; m/div > 0; div = div *10) {
			countSort(div);

		}
	}

	void display() {
	    cout << "Sorted Array: ";
		for (int i = 0; i < n; i++) {
			cout<< arr[i]<<" ";
		}
		cout<<endl;
	}
};




int main() {
	RadixSort rs;
	rs.input();
	rs.radixSort();
	rs.display();
	return 0;
}