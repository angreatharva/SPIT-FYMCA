#include<iostream>
#define max 100
using namespace std;
int n,arr[max],key,choice;


class LinearSearch
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
		cout << "Array ";
		for(int i = 0; i < n; i++) {
			cout << arr[i] << " ";
		}
		cout << endl;
	}

	void menu() {
		cout<<"Enter choice\n";
		cout<<"1.) Press 1 to do Linear Search\n";
		cout<<"2.) Press 2 to Exit\n";
		cin>>choice;

	}
	void search()
	{
		cout<<"Enter the element you want to search: ";
		cin>>key;
		int pos=-1;
		for (int i=0; i<=n; i++)
		{
			if(key==arr[i])
			{
				pos=i;
				break;
			}
		}
		if(pos==-1)
		{
			cout<<"Element "<< key <<" is not found\n";
			cout<<"Elemnt will be inserted at the end\n";

			arr[n] = key;
			n++;

			cout << "New Array ";
			for(int i = 0; i < n; i++) {
				cout << arr[i] << " ";
			}
			cout << endl;
		}
		else
		{
			cout<<"Element "<< key <<" is found at Index "<< pos << endl ;
		}
	}

};
int main()
{
	LinearSearch ls;
	ls.input();
	do {
		ls.menu();
		if (choice == 1) {
			ls.search();
		}
	} while (choice != 2);
	return 0;
}