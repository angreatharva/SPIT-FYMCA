#include <iostream>
using namespace std;

const int MAX = 100;
int n, arr[MAX];

class MergeSort {
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

	void merge(int low, int mid, int high) {
		int l1 = mid - low + 1;
		int l2 = high - mid;

		int a1[l1], a2[l2];

		for (int i = 0; i < l1; i++) {
			a1[i] = arr[low + i];
		}

		for (int j = 0; j < l2; j++) {
			a2[j] = arr[mid + 1 + j];
		}

		int i = 0, j = 0, k = low;

		while (i < l1 && j < l2) {
			if (a1[i] < a2[j]) {
				arr[k] = a1[i];
				i++;
			} else {
				arr[k] = a2[j];
				j++;
			}
			k++;
		}

		while (i < l1) {
			arr[k] = a1[i];
			i++;
			k++;
		}

		while (j < l2) {
			arr[k] = a2[j];
			j++;
			k++;
		}
	}

	void mergeSort(int low, int high) {
		if (low < high) {
			int mid = (low + high) / 2;
			mergeSort(low, mid);
			mergeSort(mid + 1, high);
			merge(low, mid, high);
		}
	}

	void sort() {
		mergeSort(0, n - 1);
	}

	void display() {
	    cout << "Sorted Array: ";
		for (int i = 0; i < n; i++) {
			cout << arr[i] << " ";
		}
		cout << endl;
	}
};

int main() {
	MergeSort ms;
	ms.input();
	ms.sort();
	ms.display();
	return 0;
}
