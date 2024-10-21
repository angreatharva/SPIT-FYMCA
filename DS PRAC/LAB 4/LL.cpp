#include <iostream>

using namespace std;

int value, ch, key, target;
struct node
{
    int data;
    struct node *next;
}
    *list = NULL,
    *p, *q, *r;
class LinkedList
{
public:
    void menu()
    {
        do
        {
            cout << endl;
            cout << "Enter you choice:" << endl;
            cout << "1) Insert at the Beginning" << endl;
            cout << "2) Insert at the End" << endl;
            cout << "3) Insert Before a Particular Element" << endl;
            cout << "4) Insert After a Particular Element" << endl;
            cout << "10) Display" << endl;
            cout << "15) Exit" << endl;
            cout << endl;

            cin >> ch;
            switch (ch)
            {
            case 1:
                insertAtBeginning();
                break;

            case 2:
                insertAtEnd();
                break;

            case 3:
                insertBeforeParticularElement();
                break;
            case 4:
                insertAfterParticularElement();
                break;

            case 10:
                display();
                break;

            default:
                cout << "Enter a proper Value";
                break;
            }

        } while (ch != 15);
    }

    void insertAtBeginning()
    {
        p = (struct node *)malloc(sizeof(node));
        cout << "Enter the element you want to Insert:" << endl;
        cin >> key;
        p->data = key;
        if (list == NULL)
        {
            p->next = NULL;
        }
        else
        {
            p->next = list;
        }
        list = p;
    }

    void insertAtEnd()
    {
        p = (struct node *)malloc(sizeof(node));
        cout << "Enter the element you want to Insert:" << endl;
        cin >> key;
        p->data = key;
        p->next = NULL;
        if (list == NULL)
        {
            cout << "List is Empty Inserting, so Inserting at the Start" << endl;
            list = p;
        }
        else
        {
            q = list;
            while (q->next != NULL)
            {
                cout << q->data << endl;
                q = q->next;
            }
            q->next = p;
        }
    }

    void insertBeforeParticularElement()
    {
        if (list == NULL)
        {
            cout << "List is Empty" << endl;
        }
        else
        {
            cout << "Enter the Element before which you want to Insert the Element" << endl;
            cin >> target;

            q = list;
            while (q != NULL && q->data != target)
            {
                r = q;
                q = q->next;
            }
            if (q->data == target)
            {
                p = (struct node *)malloc(sizeof(node));
                cout << "Enter the element you want to Insert:" << endl;
                cin >> key;
                p->data = key;
                r->next = p;
                p->next = q;
            }
            else
            {
                cout << "Element not Found !" << endl;
            }
        }
    }

    void insertAfterParticularElement()
    {
        if (list == NULL)
        {
            cout << "List is Empty" << endl;
        }
        else
        {
            cout << "Enter the Element after which you want to Insert the Element" << endl;
            cin >> target;

            r = list;
            while (r != NULL && r->data != target)
            {
                q = r;
                r = r->next;
            }
            if (r->data == target)
            {
                p = (struct node *)malloc(sizeof(node));
                cout << "Enter the element you want to Insert:" << endl;
                cin >> key;
                p->data = key;
                p->next = r->next;
                r->next = p;
            }
            else
            {
                cout << "Element not Found !" << endl;
            }
        }
    }

    void display()
    {
        if (list == NULL)
        {
            cout << endl
                 << "Linked List is Empty";
        }
        else
        {
            q = list;
            while (q != NULL)
            {
                cout << q->data << "-->";
                q = q->next;
            }
            // cout << "START";
        }
    }
};

int main()
{
    LinkedList ll;
    ll.menu();
    return 0;
}