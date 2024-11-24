#include <iostream>
#include <stack>
#include <iomanip>
using namespace std;

class BalancingParenthesis
{
private:
    string exp;
    int step = 1;

    string getStackContents(stack<char> st)
    {
        string contents;
        while (!st.empty())
        {
            contents = st.top() + contents;
            st.pop();
        }
        return contents;
    }

public:
    void input()
    {
        cout << "Enter the Expression: ";
        cin >> exp;
    }

    void calculation()
    {
        stack<char> st;

        cout << setw(10) << "Symbol"
             << setw(25) << "Stack Contents"
             << endl;
        cout << string(40, '-') << endl;

        for (char ch : exp)
        {
            if (ch == '(')
            {
                st.push(ch);
            }
            else if (ch == ')')
            {
                if (!st.empty() && st.top() == '(')
                {
                    st.pop();
                }
                else
                {
                    st.push(ch);
                }
            }

            cout << setw(10) << ch
                 << setw(25) << getStackContents(st)
                 << endl;
        }

        cout << string(40, '-') << endl;
        if (st.empty())
        {
            cout << "Expression has balanced parentheses.\n";
        }
        else
        {
            cout << "Expression does not have balanced parentheses.\n";
        }
    }
};

int main()
{
    BalancingParenthesis bp;
    bp.input();
    bp.calculation();
    return 0;
}
