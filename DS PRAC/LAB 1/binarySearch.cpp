
#include<iostream>
#define max 100
using namespace std;
int n,arr[max],low,high,mid,pos=-1,key,choice;

class BinarySearch
{
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
	void sort()
	{
		for(int i=0; i<n; i++)
		{
			for(int j=0; j<n-i-1; j++)
			{
				if(arr[j]>arr[j+1])
				{
					int temp;
					temp=arr[j];
					arr[j]=arr[j+1];
					arr[j+1]=temp;
				}
			}
		}
		cout << "Sorted Array: ";
		for(int i = 0; i < n; i++) {
			cout << arr[i] << " ";
		}
		cout << endl;
	}

	void search()
	{
		cout<<"Enter key to be searched: ";
		cin>>key;
		low=0,high=n-1;
		while(high>=low)
		{
			// mid=(low+high)/2;
			mid = low+ (((double)(high - low) / (arr[high] - arr[low]))
                 * (arr[high] - arr[low]));
			if(key==arr[mid])
			{
				pos=mid;
				break;
			}
			else if(key<arr[mid])
			{
				high=mid-1;
			}
			else
			{
				low=mid+1;
			}
		}
		if(pos==-1)
		{
			cout<<"Key not found\n";
		}
		else
		{
			cout<<"Element "<< key <<" is found at Index "<< pos << endl ;
		}
	}

	void menu() {
		cout<<"Enter choice\n";
		cout<<"1.) Press 1 to do Linear Search\n";
		cout<<"2.) Press 2 to Exit\n";
		cin>>choice;

	}
};
int main()
{
	BinarySearch bs;
	bs.input();
	bs.sort();
	do {
		bs.menu();
		if (choice == 1) {
			bs.search();
		}
	} while (choice != 2);

	return 0;
}