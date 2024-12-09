#include <iostream>
using namespace std;
#define max_d 100

int n, treeData[max_d], ch;

struct node
{
    struct node *prev;
    int data;
    struct node *next;
}
    *list = NULL,
    *p, *q, *r, *s, *temp, *root = NULL, *current, *parent, *lastVisited, *peekNode, *stack[max_d];

class AVL
{
public:
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

    void balanceFactor(node *node)
    {
        int left = height_of_leftSubTree(node);
        int right = height_of_rightSubTree(node);
        int BF = left - right;
    }

    int height_of_leftSubTree(node *node)
    {
        int res = 0;
        int left = 0;
        int right = 0;

        if (root->prev != NULL && root->next != NULL)
        {
            left++;
            right++;
        }
        else if (root->prev != NULL)
        {
            left++;
        }
        else if (root->next != NULL)
        {
            right++;
        }
        res = max(left, right);

        return res;
    }
    int height_of_rightSubTree(node *node)
    {
        int res = 0;

        int left = 0;
        int right = 0;

        if (root->prev != NULL && root->next != NULL)
        {
            left = right = 1;
        }

        return res;
    }
};
int main()
{
    AVL avl;
    avl.input();

    return 0;
}