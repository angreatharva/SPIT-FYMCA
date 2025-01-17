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

// complete
//  #include <iostream>
//  using namespace std;
//  struct Node
//  {
//      int key;
//      Node *left;
//      Node *right;
//      int height;
//  };
//  int height(Node *n)
//  {
//      return (n == nullptr) ? 0 : n->height;
//  }
//  int getBalance(Node *n)
//  {
//      return (n == nullptr) ? 0 : height(n->left) - height(n->right);
//  }
//  Node *createNode(int key)
//  {
//      Node *node = new Node();
//      node->key = key;
//      node->left = nullptr;
//      node->right = nullptr;
//      node->height = 1;
//      return node;
//  }
//  Node *rightRotate(Node *y)
//  {
//      Node *x = y->left;
//      Node *T2 = x->right;

//     x->right = y;
//     y->left = T2;

//     y->height = max(height(y->left), height(y->right)) + 1;
//     x->height = max(height(x->left), height(x->right)) + 1;

//     return x;
// }
// Node *leftRotate(Node *x)
// {
//     Node *y = x->right;
//     Node *T2 = y->left;

//     y->left = x;
//     x->right = T2;

//     x->height = max(height(x->left), height(x->right)) + 1;
//     y->height = max(height(y->left), height(y->right)) + 1;
//     return y;
// }
// Node *insert(Node *node, int key)
// {

//     if (node == nullptr)
//         return createNode(key);
//     if (key < node->key)
//         node->left = insert(node->left, key);
//     else if (key > node->key)
//         node->right = insert(node->right, key);
//     else
//         return node;
//     node->height = 1 + max(height(node->left), height(node->right));
//     int balance = getBalance(node);
//     cout << "Node: " << node->key << ", Balance Factor: " << getBalance(node) << endl;
//     if (balance > 1 && key < node->left->key)
//         return rightRotate(node);
//     if (balance < -1 && key > node->right->key)
//         return leftRotate(node);

//     if (balance > 1 && key > node->left->key)
//     {
//         node->left = leftRotate(node->left);
//         return rightRotate(node);
//     }

//     if (balance < -1 && key < node->right->key)
//     {
//         node->right = rightRotate(node->right);
//         return leftRotate(node);
//     }
//     return node;
// }
// void inOrder(Node *root)
// {
//     if (root != nullptr)
//     {
//         inOrder(root->left);
//         cout << root->key << " ";
//         inOrder(root->right);
//     }
// }
// void printBalances(Node *root)
// {
//     if (root != nullptr)
//     {
//         printBalances(root->left);
//         cout << "Node: " << root->key << ", Balance Factor: " << getBalance(root) << endl;
//         printBalances(root->right);
//     }
// }
// int main()
// {
//     Node *root = nullptr;
//     int keys[] = {10, 20, 30, 40, 50, 25};
//     for (int key : keys)
//     {
//         root = insert(root, key);
//     }
//     cout << "In-order traversal of the AVL tree:" << endl;
//     inOrder(root);
//     cout << endl;
//     cout << "Balance factors of nodes:" << endl;
//     printBalances(root);
//     return 0;
// }