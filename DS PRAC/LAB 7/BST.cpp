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
    *p, *q, *r, *s, *temp, *root = NULL, *current, *parent;

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

        struct node *stack[max];
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

    void
    PreOrder()
    {
    }

    void
    PostOrder()
    {
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