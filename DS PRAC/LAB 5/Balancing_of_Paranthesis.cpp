#include <iostream>
#include <stack>
using namespace std;

class BalancingParenthesis
{
public:
    string exp;

    bool bracketsMatch(char open, char close)
    {
        return (open == '(' && close == ')') ||
               (open == '{' && close == '}') ||
               (open == '[' && close == ']');
    }

    void input()
    {
        cout << "Enter the Expression: ";
        cin >> exp;
    }

    void calculation()
    {
        stack<char> st;

        for (char ch : exp)
        {
            if (ch == '(' || ch == '{' || ch == '[')
            {
                st.push(ch);
            }
            else if (ch == ')' || ch == '}' || ch == ']')
            {
                if (!st.empty() && bracketsMatch(st.top(), ch))
                {
                    st.pop();
                }
                else
                {
                    st.push(ch);
                }
            }
        }

        if (st.empty())
        {
            cout << "Expression has balanced brackets.\n";
        }
        else
        {
            cout << "Expression does not have balanced brackets.\n";
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
