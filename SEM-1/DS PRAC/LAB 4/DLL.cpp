#include <iostream>

using namespace std;

int value, ch, key, target;
struct node
{
    struct node *prev;
    int data;
    struct node *next;
}
    *list = NULL,
    *p, *q, *r, *s, *temp;
class DoublyLinkedList
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
                sortLinkedList();
                break;
            case 9:
                reverse();
                break;
            case 10:
                display();
                break;
            case 11:
                Search();
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
        p->prev = NULL;

        if (list == NULL)
        {
            p->next = NULL;
        }
        else
        {
            p->next = list;
            list->prev = p;
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
            list->prev = NULL;
        }
        else
        {
            q = list;
            while (q->next != NULL)
            {
                // cout << q->data << endl;
                q = q->next;
            }
            q->next = p;
            p->prev = q;
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
                p->prev = NULL;
                list->prev = p;
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
                p->prev = q->prev;

                if (q->prev != NULL)
                {
                    q->prev->next = p;
                }
                q->prev = p;
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

        q = list;
        while (q != NULL && q->data != target)
        {
            q = q->next;
        }

        if (q != NULL)
        {

            p = new node;
            cout << "Enter the element you want to insert: ";
            cin >> key;

            p->data = key;

            p->prev = q;
            p->next = q->next;

            if (q->next != NULL)
            {
                q->next->prev = p;
            }
            q->next = p;
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
                list->prev = NULL;
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
            if (q->data == target)
            {
                cout << "Deleted " << q->data << endl;
                list = q->next;
                if (list != NULL)
                {
                    list->prev = NULL;
                }
                free(q);
                return;
            }
            while (q != NULL && q->data != target)
            {
                r = q;
                q = q->next;
            }
            if (q != NULL)
            {
                cout << "Deleted " << q->data << endl;
                r->next = q->next;
                if (q->next != NULL)
                {
                    q->next->prev = r;
                }
                free(q);
            }
            else
            {
                cout << "Element not found!" << endl;
            }
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

        q = list;
        temp = NULL;
        while (q != NULL)
        {
            temp = q->prev;
            q->prev = q->next;
            q->next = temp;
            q = q->prev;
        }
        if (temp != NULL)
        {
            list = temp->prev;
        }
    }

    void Search()
    {
        if (list == NULL) // Check if the list is empty
        {
            cout << "List is Empty" << endl;
        }
        else
        {
            cout << "Enter the Element you want to Search" << endl;
            cin >> target;

            // Traverse the list from head to tail
            q = list;
            int i = 0;
            while (q != NULL) // Traverse until the node is NULL
            {
                if (q->data == target)
                {
                    cout << "Element Found at " << i << "th Index" << endl;
                    return;
                }
                q = q->next;
                i++;
            }

            // If element is not found
            cout << "Element not found!" << endl;
        }
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
    DoublyLinkedList dll;
    dll.menu();
    return 0;
}