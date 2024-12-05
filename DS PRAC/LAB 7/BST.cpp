#include <iostream>
using namespace std;
#define max 100

int n, treeData[max], ch;

struct node
{
    struct node *prev;
    int data;
    struct node *next;
}
    *list = NULL,
    *p, *q, *r, *s, *temp, *root = NULL, *current, *parent, *lastVisited, *peekNode, *stack[max];

class BST
{
public:
    void menu()
    {

        do
        {
            cout << endl;
            cout << "Enter you choice:" << endl;
            cout << "1) InOrder" << endl;
            cout << "2) PreOrder" << endl;
            cout << "3) PostOrder" << endl;
            cout << "4) Exit" << endl;

            cin >> ch;

            switch (ch)
            {
            case 1:
                InOrder();
                break;
            case 2:
                PreOrder();
                break;
            case 3:
                PostOrder();
                break;

            default:
                cout << "Enter proper value." << endl;
                break;
            }
        } while (ch != 4);
    }

    void InOrder()
    {
        if (root == NULL)
        {
            cout << "Tree is empty!" << endl;
            return;
        }

        int top = -1;
        current = root;

        while (current != NULL || top != -1)
        {
            while (current != NULL)
            {
                stack[++top] = current;
                current = current->prev;
            }

            current = stack[top--];
            cout << current->data << " ";
            current = current->next;
        }
        cout << endl;
    }

    void PreOrder()
    {
        if (root == NULL)
        {
            cout << "Tree is empty!" << endl;
            return;
        }

        int top = -1;
        stack[++top] = root;

        while (top != -1)
        {
            current = stack[top--];
            cout << current->data << " ";

            if (current->next != NULL)
                stack[++top] = current->next;
            if (current->prev != NULL)
                stack[++top] = current->prev;
        }
        cout << endl;
    }

    void PostOrder()
    {
        if (root == NULL)
        {
            cout << "Tree is empty!" << endl;
            return;
        }

        int top = -1;
        lastVisited = NULL;
        current = root;

        while (current != NULL || top != -1)
        {
            if (current != NULL)
            {
                stack[++top] = current;  // Push the current node
                current = current->prev; // Move to the left child
            }
            else
            {
                peekNode = stack[top]; // Peek the top node of the stack

                // If the right child exists and has not been visited yet
                if (peekNode->next != NULL && lastVisited != peekNode->next)
                {
                    current = peekNode->next; // Move to the right child
                }
                else
                {
                    // Visit the node
                    cout << peekNode->data << " ";
                    lastVisited = stack[top--]; // Pop the stack
                }
            }
        }
        cout << endl;
    }

    void input()
    {
        cout << "Enter the size of data:" << endl;
        cin >> n;

        treeData[n];
        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Index: ";
            cin >> treeData[i];
        }

        for (int i = 0; i < n; i++)
        {
            createTree(treeData[i]);
        }
    }

    void createTree(int key)
    {
        p = (struct node *)malloc(sizeof(node));

        p->data = key;
        p->prev = NULL;
        p->next = NULL;

        if (root == NULL)
        {
            root = p;
            return;
        }

        current = root;
        parent = NULL;

        while (current != NULL)
        {
            parent = current;
            if (key < current->data)
            {
                current = current->prev;
            }
            else
            {
                current = current->next;
            }
        }

        if (key < parent->data)
        {
            parent->prev = p;
        }
        else
        {
            parent->next = p;
        }
    }
};
int main()
{
    BST bst;
    bst.input();
    bst.menu();
    return 0;
}