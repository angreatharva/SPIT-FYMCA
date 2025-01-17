#include <iostream>
#define max 100
using namespace std;

int i = 0, n, ch, arr[max], key;

class Stack
{
public:
    void input()
    {
        cout << "Enter the size of the Stack: ";
        cin >> n;
    }

    void menu()
    {
        do
        {
            cout << endl
                 << "Select options: ";
            cout << endl
                 << "1 Push ";
            cout << endl
                 << "2 Pop";
            cout << endl
                 << "3 Display";
            cout << endl
                 << "4 Exit" << endl
                 << endl;
            cin >> ch;
            switch (ch)
            {
            case 1:
                Push();
                break;
            case 2:
                Pop();
                break;
            case 3:
                Display();
                break;
            case 4:
                break;
            default:
                cout << "Enter proper Option." << endl;
                break;
            }
        } while (ch != 4);
    }

    void Push()
    {
        if (i >= n)
        {
            cout << "Stack Overflow!!!" << endl;
            return;
        }
        cout << endl
             << "Enter the Element you want to Push into the Stack" << endl;
        cin >> key;
        arr[i] = key;
        i++;
    }

    void Pop()
    {
        if (i <= 0)
        {
            cout << "Stack Underflow!!!" << endl;
            return;
        }
        i--;
        cout << endl
             << "Popped element: " << arr[i] << endl;
    }

    void Display()
    {
        if (i == 0)
        {
            cout << "Stack is empty." << endl;
            return;
        }
        cout << endl
             << "Displaying Stack" << endl;
        for (int j = i - 1; j >= 0; j--)
        {
            cout << arr[j] << endl;
        }
    }
};

int main()
{
    Stack sk;
    sk.input();
    sk.menu();
    return 0;
}
