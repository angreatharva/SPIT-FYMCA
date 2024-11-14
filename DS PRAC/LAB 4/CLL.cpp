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
class CircularLinkedList
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
            cout << "11) Search a particular " << endl;
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
                // sortLinkedList();
                break;
            case 9:
                // reverse();
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
        p = new node();
        cout << "Enter the element you want to Insert:" << endl;
        cin >> key;
        p->data = key;
        if (list == NULL)
        {
            list = p;
            p->next = list;
        }
        else
        {
            q = list;
            while (q->next != list)
            {
                q = q->next;
            }
            p->next = list;
            q->next = p;
            list = p;
        }
    }

    void insertAtEnd()
    {
        p = new node();
        cout << "Enter the element you want to Insert:" << endl;
        cin >> key;
        p->data = key;
        if (list == NULL)
        {
            list = p;
            p->next = list;
        }
        else
        {
            q = list;
            while (q->next != list)
            {
                q = q->next;
            }
            q->next = p;
            p->next = list;
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
                insertAtBeginning();
                return;
            }

            q = list;
            do
            {
                r = q;
                q = q->next;
            } while (q != list && q->data != target);

            if (q->data == target)
            {
                p = new node();
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
        do
        {
            if (r->data == target)
            {
                p = new node();
                cout << "Enter the element you want to insert: ";
                cin >> key;
                p->data = key;
                p->next = r->next;
                r->next = p;
                return;
            }
            r = r->next;
        } while (r != list);

        cout << "Element not found!" << endl;
    }

    void deleteAtBeginning()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
            return;
        }
        q = list;
        if (q->next == list)
        {
            cout << "Deleted " << q->data << endl;
            delete q;
            list = NULL;
        }
        else
        {
            while (q->next != list)
            {
                q = q->next;
            }
            p = list;
            cout << "Deleted " << p->data << endl;
            list = list->next;
            q->next = list;
            delete p;
        }
    }

    void deleteAtEnd()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
            return;
        }
        q = list;
        if (q->next == list)
        {
            cout << "Deleted " << q->data << endl;
            delete q;
            list = NULL;
        }
        else
        {
            while (q->next->next != list)
            {
                q = q->next;
            }
            p = q->next;
            cout << "Deleted " << p->data << endl;
            q->next = list;
            delete p;
        }
    }

    void deleteAParticularElement()
    {
        if (list == NULL)
        {
            cout << "Linked List is Empty" << endl;
            return;
        }
        cout << "Enter the Element which you want to Delete" << endl;
        cin >> target;

        if (list->data == target)
        {
            deleteAtBeginning();
            return;
        }

        q = list;
        do
        {
            r = q;
            q = q->next;
        } while (q != list && q->data != target);

        if (q->data == target)
        {
            r->next = q->next;
            cout << "Deleted " << q->data << endl;
            delete q;
        }
        else
        {
            cout << "Element not found!" << endl;
        }
    }

    void display()
    {
        if (list == NULL)
        {
            cout << "The list is empty." << endl;
            return;
        }

        q = list;
        do
        {
            cout << q->data << "-->";
            q = q->next;
        } while (q != list);
        cout << endl;
    }
};

int main()
{
    CircularLinkedList cll;
    cll.menu();
    return 0;
}