#include <iostream>
#include <cstdlib>
using namespace std;
#define max_d 100

int n, treeData[max_d], ch;

struct node
{
    struct node *prev;
    int data;
    int balanceFactor;
    struct node *next;
};

struct node *list = NULL, *p, *q, *r, *s, *temp, *root = NULL, *current, *parent, *lastVisited, *peekNode, *stack[max_d];

class AVL
{
public:
    void input()
    {
        cout << "Enter the size of data:" << endl;
        cin >> n;

        for (int i = 0; i < n; i++)
        {
            cout << "Enter the data for " << i << " Index: ";
            cin >> treeData[i];
        }

        for (int i = 0; i < n; i++)
        {
            createTree(treeData[i]);
        }
        cout << endl;
    }

    void createTree(int key)
    {
        p = (struct node *)malloc(sizeof(node));

        p->data = key;
        p->prev = NULL;
        p->next = NULL;
        p->balanceFactor = 0;

        if (root == NULL)
        {
            root = p;
            cout << "Node " << key << " inserted. Balance Factor: 0" << endl;
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

        cout << "Node " << key << " inserted." << endl;
        updateBalanceFactorsUpToRoot(p); // Update balance factors up to the root
    }

    void updateBalanceFactorsUpToRoot(node *node)
    {
        while (node != NULL)
        {
            node->balanceFactor = balanceFactor(node);
            cout << "Node " << node->data << " updated Balance Factor: " << node->balanceFactor << endl;
            node = findParent(node);
        }

        cout << "--------------------------------------------" << endl;
    }

    int balanceFactor(node *node)
    {
        int leftHeight = height(node->prev);
        int rightHeight = height(node->next);
        return leftHeight - rightHeight;
    }

    int height(node *node)
    {
        if (node == NULL)
            return 0;

        int leftHeight = height(node->prev);
        int rightHeight = height(node->next);

        return 1 + max(leftHeight, rightHeight);
    }

    node *findParent(node *child)
    {
        node *current = root;
        node *parent = NULL;
        while (current != NULL && current != child)
        {
            parent = current;
            if (child->data < current->data)
            {
                current = current->prev;
            }
            else
            {
                current = current->next;
            }
        }
        return parent;
    }
};

int main()
{
    AVL avl;
    avl.input();

    return 0;
}
