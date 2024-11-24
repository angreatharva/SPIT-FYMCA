#include <iostream>
#include <stack>
#include <iomanip>
#include <string>
#include <cctype>
using namespace std;

class PostfixEvaluation
{
private:
    string exp;

public:
    void input()
    {
        cout << "Enter the Postfix Expression: ";
        cin >> exp;
    }

    void conversion()
    {
        stack<int> st;

        cout << setw(10) << "Symbol"
             << setw(25) << "Stack Contents"
             << endl;
        cout << string(40, '-') << endl;

        for (char ch : exp)
        {
            if (isdigit(ch))
            {
                st.push(ch - '0');
            }
            else
            {
                if (st.size() < 2)
                {
                    cout << "Error: Invalid Postfix Expression\n";
                    return;
                }
                int b = st.top();
                st.pop();
                int a = st.top();
                st.pop();

                switch (ch)
                {
                case '+':
                    st.push(a + b);
                    break;
                case '-':
                    st.push(a - b);
                    break;
                case '*':
                    st.push(a * b);
                    break;
                case '/':
                    if (b == 0)
                    {
                        cout << "Error: Division by zero\n";
                        return;
                    }
                    st.push(a / b);
                    break;
                default:
                    cout << "Error: Unknown operator " << ch << "\n";
                    return;
                }
            }

            cout << setw(10) << ch
                 << setw(25) << getStackContents(st)
                 << endl;
        }

        cout << string(40, '-') << endl;
        if (st.size() == 1)
        {
            cout << "Result of the Postfix Expression: " << st.top() << endl;
        }
        else
        {
            cout << "Error: Invalid Postfix Expression\n";
        }
    }

private:
    string getStackContents(stack<int> st)
    {
        string contents;
        while (!st.empty())
        {
            contents = to_string(st.top()) + " " + contents;
            st.pop();
        }
        return contents;
    }
};

int main()
{
    PostfixEvaluation pe;
    pe.input();
    pe.conversion();
    return 0;
}
