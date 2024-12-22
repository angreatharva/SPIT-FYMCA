#include <iostream>
using namespace std;

// Code 1: Implementing 3 Stacks using a Single Array
class ThreeStacks
{
    int *arr;
    int top1, top2, top3, size, size1;

public:
    ThreeStacks(int n)
    {
        size = n;
        size1 = n / 3;
        arr = new int[size];
        top1 = -1;
        top2 = size1 - 1;
        top3 = 2 * size1 - 1;
    }

    ~ThreeStacks()
    {
        delete[] arr;
    }

    void push1(int x)
    {
        if (top1 < size1 - 1)
        {
            arr[++top1] = x;
        }
        else
        {
            cout << "Stack 1 Overflow" << endl;
        }
    }

    void push2(int x)
    {
        if (top2 < 2 * size1 - 1)
        {
            arr[++top2] = x;
        }
        else
        {
            cout << "Stack 2 Overflow" << endl;
        }
    }

    void push3(int x)
    {
        if (top3 < size - 1)
        {
            arr[++top3] = x;
        }
        else
        {
            cout << "Stack 3 Overflow" << endl;
        }
    }

    int pop1()
    {
        if (top1 >= 0)
        {
            return arr[top1--];
        }
        else
        {
            cout << "Stack 1 Underflow" << endl;
            return -1;
        }
    }

    int pop2()
    {
        if (top2 >= size1)
        {
            return arr[top2--];
        }
        else
        {
            cout << "Stack 2 Underflow" << endl;
            return -1;
        }
    }

    int pop3()
    {
        if (top3 >= 2 * size1)
        {
            return arr[top3--];
        }
        else
        {
            cout << "Stack 3 Underflow" << endl;
            return -1;
        }
    }

    void display()
    {
        cout << "\nStack 1: ";
        for (int i = 0; i <= top1; ++i)
        {
            cout << arr[i] << " ";
        }

        cout << "\nStack 2: ";
        for (int i = size1; i <= top2; ++i)
        {
            cout << arr[i] << " ";
        }

        cout << "\nStack 3: ";
        for (int i = 2 * size1; i <= top3; ++i)
        {
            cout << arr[i] << " ";
        }
        cout << endl;
    }

    void menu()
    {
        int choice;

        do
        {
            cout << "\nMain Menu:\n";
            cout << "1. Push into a Stack\n";
            cout << "2. Pop from a Stack\n";
            cout << "3. Display Stacks\n";
            cout << "4. Exit\n";
            cout << "Enter your choice: ";
            cin >> choice;

            switch (choice)
            {
            case 1:
            {
                int stackNum, value;
                cout << "Enter stack number (1-3): ";
                cin >> stackNum;
                cout << "Enter value to push: ";
                cin >> value;

                if (stackNum == 1)
                    push1(value);
                else if (stackNum == 2)
                    push2(value);
                else if (stackNum == 3)
                    push3(value);
                else
                    cout << "Invalid stack number.\n";
                break;
            }

            case 2:
            {
                int stackNum;
                cout << "Enter stack number (1-3): ";
                cin >> stackNum;

                if (stackNum == 1)
                    cout << "Popped: " << pop1() << endl;
                else if (stackNum == 2)
                    cout << "Popped: " << pop2() << endl;
                else if (stackNum == 3)
                    cout << "Popped: " << pop3() << endl;
                else
                    cout << "Invalid stack number.\n";
                break;
            }

            case 3:
                display();
                break;

            case 4:
                cout << "Exiting program.\n";
                break;

            default:
                cout << "Invalid choice. Please try again.\n";
            }
        } while (choice != 4);
    }
};

int main()
{
    int stackSize;
    cout << "Enter size for the three stacks: ";
    cin >> stackSize;

    ThreeStacks stacks(stackSize);
    stacks.menu();

    return 0;
}
