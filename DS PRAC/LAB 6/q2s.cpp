#include <iostream>
#define MAXSIZE 100
using namespace std;

class Stack
{
private:
    int *arr;
    int topIndex;
    int capacity;

public:
    Stack(int size)
    {
        capacity = size;
        arr = new int[capacity];
        topIndex = -1;
    }

    void push(int value)
    {
        if (topIndex == capacity - 1)
        {
            cerr << "Stack overflow\n";
            return;
        }
        arr[++topIndex] = value;
    }

    int pop()
    {
        if (topIndex == -1)
        {
            cerr << "Stack underflow\n";
            return -1;
        }
        return arr[topIndex--];
    }

    bool isEmpty()
    {
        return topIndex == -1;
    }

    int top()
    {
        if (topIndex == -1)
        {
            cerr << "Stack is empty\n";
            return -1;
        }
        return arr[topIndex];
    }
};

class Queue
{
private:
    Stack *stack1;
    Stack *stack2;

public:
    Queue()
    {
        stack1 = new Stack(MAXSIZE);
        stack2 = new Stack(MAXSIZE);
    }

    void enqueue(int value)
    {
        if (stack1->isEmpty() && stack2->isEmpty() && stack1->top() == MAXSIZE - 1)
        {
            cerr << "Queue overflow\n";
            return;
        }
        stack1->push(value);
    }

    int dequeue()
    {
        if (stack2->isEmpty())
        {
            while (!stack1->isEmpty())
            {
                stack2->push(stack1->pop());
            }
        }
        int result = stack2->pop();
        if (result == -1)
        {
            cerr << "Queue underflow\n";
        }
        return result;
    }

    void display()
    {
        Stack temp1(*stack1), temp2(*stack2);

        while (!temp2.isEmpty())
        {
            cout << temp2.pop() << " ";
        }

        while (!temp1.isEmpty())
        {
            temp2.push(temp1.pop());
        }

        while (!temp2.isEmpty())
        {
            cout << temp2.pop() << " ";
        }

        cout << "\n";
    }
};

int main()
{
    Queue q;
    int choice, value;

    do
    {
        cout << "\nMenu:\n";
        cout << "1. Enqueue\n";
        cout << "2. Dequeue\n";
        cout << "3. Display\n";
        cout << "4. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice)
        {
        case 1:
            cout << "Enter value to enqueue: ";
            cin >> value;
            q.enqueue(value);
            break;
        case 2:
            value = q.dequeue();
            if (value != -1)
            {
                cout << "Dequeued: " << value << "\n";
            }
            break;
        case 3:
            cout << "Queue contents: ";
            q.display();
            break;
        case 4:
            cout << "Exiting...\n";
            break;
        default:
            cout << "Invalid choice, please try again.\n";
        }
    } while (choice != 4);

    return 0;
}
