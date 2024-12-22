#include <iostream>

using namespace std;

struct PolyNode
{
    int coeff;
    int pow;
    PolyNode *next;
};

class Polynomial
{
    PolyNode *head;

public:
    Polynomial() : head(nullptr) {}

    void insert(int coeff, int pow)
    {
        PolyNode *newNode = new PolyNode{coeff, pow, nullptr};
        if (!head || head->pow < pow)
        {
            newNode->next = head;
            head = newNode;
        }
        else
        {
            PolyNode *temp = head;
            while (temp->next && temp->next->pow >= pow)
            {
                temp = temp->next;
            }
            newNode->next = temp->next;
            temp->next = newNode;
        }
    }

    Polynomial subtract(Polynomial &p2)
    {
        Polynomial result;
        PolyNode *p1Node = head, *p2Node = p2.head;
        while (p1Node || p2Node)
        {
            if (!p2Node || (p1Node && p1Node->pow > p2Node->pow))
            {
                result.insert(p1Node->coeff, p1Node->pow);
                p1Node = p1Node->next;
            }
            else if (!p1Node || (p2Node && p2Node->pow > p1Node->pow))
            {
                result.insert(-p2Node->coeff, p2Node->pow);
                p2Node = p2Node->next;
            }
            else
            {
                result.insert(p1Node->coeff - p2Node->coeff, p1Node->pow);
                p1Node = p1Node->next;
                p2Node = p2Node->next;
            }
        }
        return result;
    }

    void display()
    {
        PolyNode *temp = head;
        while (temp)
        {
            cout << temp->coeff << "x^" << temp->pow;
            temp = temp->next;
            if (temp)
                cout << " + ";
        }
        cout << endl;
    }
};

int main()
{
    int terms, coeff, pow;
    Polynomial poly1, poly2, result;

    cout << "Enter number of terms for Polynomial 1: ";
    cin >> terms;
    for (int i = 0; i < terms; ++i)
    {
        cout << "Enter coefficient and power: ";
        cin >> coeff >> pow;
        poly1.insert(coeff, pow);
    }

    cout << "Enter number of terms for Polynomial 2: ";
    cin >> terms;
    for (int i = 0; i < terms; ++i)
    {
        cout << "Enter coefficient and power: ";
        cin >> coeff >> pow;
        poly2.insert(coeff, pow);
    }

    result = poly1.subtract(poly2);
    cout << "Resultant Polynomial after Subtraction: ";
    result.display();

    return 0;
}
