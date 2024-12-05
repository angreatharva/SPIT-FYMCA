#include <iostream>
#define MAX 100
using namespace std;

int front = -1, rear = -1, n, queue[MAX];

class CircularQueue
{
public:
    void input()
    {
        cout << "Enter the size of the Queue: ";
        cin >> n;
    }

    void menu()
    {
        int ch;
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
                cout << "Enter a proper option." << endl;
                break;
            }
        } while (ch != 4);
    }

    void enqueue()
    {
        if ((rear + 1) % n == front)
        {
            cout << "Queue Overflow!" << endl;
            return;
        }

        int key;
        cout << "Enter the element you want to store in the queue: ";
        cin >> key;

        if (front == -1)
            front = 0; // Initialize front when inserting the first element.

        rear = (rear + 1) % n; // Circular increment.
        queue[rear] = key;

        display();
    }

    void dequeue()
    {
        if (front == -1)
        {
            cout << "Queue Underflow!" << endl;
            return;
        }

        cout << "Dequeued element: " << queue[front] << endl;

        if (front == rear)
        {
            // Queue becomes empty.
            front = rear = -1;
        }
        else
        {
            front = (front + 1) % n; // Circular increment.
        }

        display();
    }

    void display()
    {
        if (front == -1)
        {
            cout << "Queue is empty." << endl;
            return;
        }

        cout << "Queue elements: " << endl;
        int i = front;
        while (true)
        {
            cout << queue[i] << " ";
            if (i == rear)
                break;
            i = (i + 1) % n; // Circular increment.

            cout << endl;
        }
    }
};

int main()
{
    CircularQueue cq;
    cq.input();
    cq.menu();

    return 0;
}