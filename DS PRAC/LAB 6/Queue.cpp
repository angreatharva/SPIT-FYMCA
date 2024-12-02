#include <iostream>
#define max 100
using namespace std;

int i = 0, n, ch, queue[max], key, front = 0, rear = -1;

class Queue
{
public:
    void input()
    {
        cout << "Enter the size of the Queue: ";
        cin >> n;
        queue[n];
    }

    void menu()
    {
        do
        {
            cout << endl
                 << "Select options: ";
            cout << endl
                 << "1 Enqueue ";
            cout << endl
                 << "2 Dequeue";
            cout << endl
                 << "3 Display";
            cout << endl
                 << "4 Exit" << endl;
            cin >> ch;
            switch (ch)
            {
            case 1:
                enqueue();
                break;
            case 2:
                dequeue();
                break;
            case 3:
                display();
                break;
            case 4:
                break;
            default:
                cout << "Enter proper Option." << endl;
                break;
            }
        } while (ch != 4);
    }

    void enqueue()
    {

        if (rear == n - 1)
        {
            cout << "Queue Overflow.!!" << endl;
        }
        else
        {
            cout << "Enter the Element you want to store in Queue: ";
            cin >> key;

            rear++;
            queue[rear] = key;
        }
        display();
    }

    void dequeue()
    {
        if (front > rear)
        {
            cout << "Queue Underflow.!!" << endl;
        }
        else
        {
            front += 1;
            if (front > rear)
            {
                front = 0;
                rear = -1;
            }
        }
        display();
    }

    void display()
    {
        if (front > rear)
        {
            cout << "Queue is empty." << endl;
            return;
        }
        cout << endl
             << "Displaying Queue" << endl;
        for (int i = front; i <= rear; i++)
        {
            cout << queue[i] << " ";
        }
    }
};

int main()
{
    Queue qu;
    qu.input();
    qu.menu();

    return 0;
}