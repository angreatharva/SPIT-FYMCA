#include <iostream>

using namespace std;

int value, ch, key, target;
struct node
{
    int data;
    struct node *next;
}
    *list = NULL,
    *p, *q, *r, *s, *temp;
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
            cout << "5) Delete at the Beginning" << endl;
            cout << "6) Delete at the End" << endl;
            cout << "7) Delete a Particular Element" << endl;
            cout << "8) Sort the Linked List" << endl;
            cout << "9) Reverse the Linked List" << endl;
            cout << "10) Display" << endl;
            cout << "11) Search a partivular " << endl;
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
            case 5:
                deleteAtBeginning();
                break;
            case 6:
                deleteAtEnd();
                break;
            case 7:
                deleteAParticularElement();
                break;
            case 8:
                sortLinkedList();
                break;
            case 9:
                reverse();
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
            if (list->data == target)
            {
                p = (struct node *)malloc(sizeof(node));
                cout << "Enter the element you want to insert: ";
                cin >> key;
                p->data = key;
                p->next = list;
                list = p;
                return;
            }

            q = list;
            while (q != NULL && q->data != target)
            {
                r = q;
                q = q->next;
            }
            if (q != NULL && q->data == target)
            {
                struct node *p = (struct node *)malloc(sizeof(node));
                cout << "Enter the element you want to insert: ";
                cin >> key;
                p->data = key;
                p->next = q;
                r->next = p;
            }
            else
            {
                cout << "Element not found!" << endl;
            }
        }
    }

    void insertAfterParticularElement()
    {
        if (list == NULL)
        {
            cout << "List is Empty" << endl;
            return;
        }

        cout << "Enter the element after which you want to insert the new element: ";
        cin >> target;

        r = list;

        while (r != NULL && r->data != target)
        {
            r = r->next;
        }

        if (r != NULL)
        {
            p = (struct node *)malloc(sizeof(node));
            cout << "Enter the element you want to insert: ";
            cin >> key;
            p->data = key;
            p->next = r->next;
            r->next = p;
        }
        else
        {
            cout << "Element not found!" << endl;
        }
    }

    void deleteAtBeginning()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }
        else
        {
            q = list;
            if (q->next != NULL)
            {
                cout << "Deleted " << q->data << endl;
                list = q->next;
            }
            else
            {
                cout << "Deleted " << q->data << endl;
                list = NULL;
            }
            free(q);
        }
    }

    void deleteAtEnd()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }
        else
        {
            q = list;
            if (q->next == NULL)
            {
                cout << "Deleted " << q->data << endl;
                list = NULL;
            }
            else
            {
                while (q->next != NULL)
                {
                    r = q;
                    q = q->next;
                }
                cout << "Deleted " << q->data << endl;
                r->next = NULL;
            }
            free(q);
        }
    }

    void deleteAParticularElement()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }
        else
        {
            cout << "Enter the Element which you want to Delete" << endl;
            cin >> target;
            q = list;
            while (q->next != NULL && q->data != target)
            {
                r = q;
                q = q->next;
            }
            if (q->next != NULL)
            {
                cout << "Deleted " << q->data << endl;
                r->next = q->next;
            }
            else
            {
                cout << "Deleted " << q->data << endl;
                r->next = NULL;
            }
            free(q);
        }
    }

    void sortLinkedList()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }
        q = list;

        while (q != NULL)
        {
            r = q->next;
            while (r != NULL)
            {
                if (q->data > r->data)
                {
                    int temp = q->data;
                    q->data = r->data;
                    r->data = temp;
                }

                r = r->next;
            }
            q = q->next;
        }

        cout << "The Sorted Linked List is :" << endl;
        display();
    }

    void reverse()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }

        q = s = list;
        temp = NULL;
        r = q->next;
        while (r != NULL)
        {
            temp = q;
            q = r;
            r = q->next;
            q->next = temp;
        }
        list = q;
        s->next = NULL;
    }

    void display()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
        }
        else
        {
            q = list;
            while (q != NULL)
            {
                cout << q->data << "-->";
                q = q->next;
            }
        }
    }
};

int main()
{
    LinkedList ll;
    ll.menu();
    return 0;
}